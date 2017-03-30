require 'slack-notifier'

class SlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(site, status)
    return false unless site.project.slack_setting

    notifier(site).post(
      text: "[#{site.name}](#{site.url}) HTTP check returning #{status} status code.",
      icon_emoji: ':exclamation:'
    )
  end

  def notifier(site)
    Slack::Notifier.new site.project.slack_setting.webhook_url do
      defaults channel: site.project.slack_setting.channel,
               username: site.project.slack_setting.username
    end
  end
end
