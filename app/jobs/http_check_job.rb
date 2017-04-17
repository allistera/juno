require 'net/https'
require 'uri'

class HttpCheckJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Site.all.each do |site|
      response = http_check(site)
      Check.create(site: site,
                   status: response[:code],
                   time: response[:time])
    end
  end

  def http_check(site)
    response = get(site.url, site.verify_ssl)
    # Try again if it fails for verification
    response = get(site.url, site.verify_ssl) unless response[:code].to_i.between?(200, 299)
    response
  end

  def get(path, verify_ssl)
    start = Time.now
    response = HTTParty.get(path, verify: verify_ssl)
    response_time = Time.now - start
    {
      code: response.code,
      time: response_time
    }
  rescue HTTParty::ResponseError
    nil
  end
end
