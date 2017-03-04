require "net/https"
require "uri"

class HttpCheckJob < ApplicationJob
  queue_as :default

  def perform(*args)

    Site.all.each do |site|
      uri = URI.parse(site.url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)

      Check.create(site: site, status: res.code)
    end

  end
end
