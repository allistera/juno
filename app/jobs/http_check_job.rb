require 'net/https'
require 'uri'

class HttpCheckJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Site.all.each do |site|
      uri = URI.parse(site.url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      Check.create(site: site,
                   status: call(http, Net::HTTP::Get.new(uri.request_uri)))
    end
  end

  def call(http, request)
    http.request(request).code
  rescue SocketError
    nil
  end
end
