require 'slack-notifier'

class SlackNotificationJob < ApplicationJob
  queue_as :default

  def perform(site, status)
    return false unless site.project.slack_setting

    if status.between?(200, 299)
      active(site, status)
    else
      failure(site, status)
    end
  end

  def failure(site, status)
    notifier(site).post(
      text: "[#{site.name}](#{site.url}) HTTP check returning #{status} status code.",
      icon_emoji: ':exclamation:'
    )
  end

  def active(site, status)
    notifier(site).post(
      text: "[#{site.name}](#{site.url}) HTTP check returning #{status} status code.",
      icon_emoji: ':green_heart:'
    )
  end

  def notifier(site)
    Slack::Notifier.new site.project.slack_setting.webhook_url do
      defaults channel: site.project.slack_setting.channel,
               username: site.project.slack_setting.username
    end
  end
end
