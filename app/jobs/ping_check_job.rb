require 'net/https'
require 'uri'

class PingCheckJob < ApplicationJob
  queue_as :default

  def perform(site)
    response = http_check(site)
    record_response(response, site)
  end

  private

  def http_check(site)
    payload = {
      hostname: site.url
    }
    get(payload)
  end

  def get(payload)
    Probe.all.map do |probe|
      response = JSON.parse(request(probe, payload))
      {
        code: response['result']['status'],
        time: response['result']['response_time']
      }
    end
  rescue HTTParty::ResponseError, SocketError
    [{ code: '', time: '' }]
  end

  def request(probe, payload)
    HTTParty.post(probe.url + '/v1/ping',
                  body: payload.to_json,
                  headers: {
                    'Authorization' =>
                    "Bearer #{ENV['JUNO_PROBE_SECRET']}"
                  }).body
  end

  def record_response(responses, site)
    responses.each do |response|
      Check.create(site: site,
                   status: response[:code],
                   time: response[:time])

      response[:code] ? site.success! : site.fail!
    end
  end
end
