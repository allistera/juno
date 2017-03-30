require 'test_helper'

class SlackNotificationJobTest < ActiveJob::TestCase
  test 'should send slack alert' do
    payload = '{"channel":"bots","username":"MyString","text":"\\u003chttp://foo.bar|Foo Bar\\u003e' \
    ' HTTP check returning 301 status code.","icon_emoji":":exclamation:"}'
    stub_request(:post, 'http://foo.bar/')
      .with(body: { 'payload' => payload })
      .to_return(status: 200)
    SlackNotificationJob.perform_now(sites(:one), 301)
  end

  test 'should fail if no slack settings' do
    refute SlackNotificationJob.perform_now(sites(:two), 301)
  end
end
