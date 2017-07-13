require 'net/https'
require 'uri'

class HttpCheckJob < ApplicationJob
  queue_as :default

  def perform(site)
    response = http_check(site)
    Check.create(site: site,
                 status: response[:code],
                 time: response[:time])

    ActionCable.server.broadcast 'status',
                                 site: site.id,
                                 name: site.name,
                                 url: site.url,
                                 state: site.state
  end

  def http_check(site)
    response = get(site.url, site.verify_ssl, basic_auth(site))
    # Try again if it fails for verification
    response = get(site.url, site.verify_ssl, basic_auth(site)) unless success?(site, response[:code])
    response
  end

  def get(path, verify_ssl, basic_auth)
    start = Time.now

    response = HTTParty.get(path, verify: verify_ssl, basic_auth: basic_auth)
    response_time = Time.now - start
    {
      code: response.code,
      time: response_time
    }
  rescue HTTParty::ResponseError, SocketError
    { code: '' }
  end

  private

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
end
