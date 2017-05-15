class HealthCheckJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Site.all.each do |site|
      HttpCheckJob.perform_later(site)
    end
  end
end
