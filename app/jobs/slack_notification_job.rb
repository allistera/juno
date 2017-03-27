require 'slack-notifier'

class SlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(site)
    return unless site.project.slack_setting

    notifier(site).ping "#{site.name} failing to return a successful status code."
  end

  def notifier(site)
    Slack::Notifier.new site.project.slack_setting.webhook_url do
      defaults channel: site.project.slack_setting.channel,
               username: site.project.slack_setting.username
    end
  end
end
