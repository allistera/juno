require 'net/https'
require 'uri'

class HttpCheckJob < ApplicationJob
  queue_as :default

  def perform(site)
    response = http_check(site)
    record_response(response, site)
  end

  private

  def http_check(site)
    payload = {
      url: site.url,
      verify_ssl: site.verify_ssl,
      basic_auth: basic_auth(site)
    }
    get(payload)
  end

  def get(payload)
    Probe.all.map do |probe|
      response = JSON.parse(request(probe, payload))
      {
        code: response['Result']['StatusCode'],
        time: response['Result']['ResponseTime']
      }
    end
  rescue HTTParty::ResponseError, SocketError
    [{ code: '', time: '' }]
  end

  def request(probe, payload)
    HTTParty.post(probe.url + '/v1/request',
                  body: payload.to_json,
                  headers: {
                    'Authorization' =>
                    "Bearer #{ENV['JUNO_PROBE_SECRET']}"
                  }).body
  end

  def success?(site, code)
    if site.custom_status
      code.to_i == site.custom_status
    else
      code.to_i.between?(200, 299)
    end
  end

  def basic_auth(site)
    { username: site.basic_auth_username, password: site.basic_auth_password }
  end

  def record_response(responses, site)
    responses.each do |response|
      Check.create(site: site,
                   status: response[:code],
                   time: response[:time])

      success?(site, response[:code]) ? site.success! : site.fail!
    end
  end
end
