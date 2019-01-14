# frozen_string_literal: true

require 'test_helper'

class SlackNotificationJobTest < ActiveJob::TestCase
  describe '#perform_now' do
    it 'sends slack alert on failure' do
      payload = '{"channel":"bots","username":"MyString","text":"\\u003chttp://foo.bar|Foo Bar\\u003e' \
      ' HTTP check returning 301 status code.","icon_emoji":":exclamation:"}'
      stub_request(:post, 'http://foo.bar/')
        .with(body: { 'payload' => payload })
        .to_return(status: 200)
      SlackNotificationJob.perform_now(sites(:one), 301)
    end

    it 'sends slack alert on success' do
      payload = '{"channel":"bots","username":"MyString","text":"\\u003chttp://foo.bar|Foo Bar\\u003e' \
      ' HTTP check returning 201 status code.","icon_emoji":":green_heart:"}'
      stub_request(:post, 'http://foo.bar/')
        .with(body: { 'payload' => payload })
        .to_return(status: 200)
      SlackNotificationJob.perform_now(sites(:one), 201)
    end

    it 'fails if no slack settings' do
      refute SlackNotificationJob.perform_now(sites(:no_slack_settings), 301)
    end
  end
end
