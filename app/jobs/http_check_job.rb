require 'net/https'
require 'uri'

class HttpCheckJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Site.all.each do |site|
      Check.create(site: site,
                   status: http_check(site))
    end
  end

  def http_check(site)
    response = get(site.url).code
    # Try again if it fails for verification
    response = get(site.url).code unless response.to_i.between?(200, 299)
    response
  end

  def get(path)
    HTTParty.get(path)
  rescue HTTParty::ResponseError
    nil
  end
end
