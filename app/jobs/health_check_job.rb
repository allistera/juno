class HealthCheckJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Site.all.each do |site|
      HttpCheckJob.perform_later(site) if site.site_type == 'http'
      PingCheckJob.perform_later(site) if site.site_type == 'ping'
    end
  end
end
