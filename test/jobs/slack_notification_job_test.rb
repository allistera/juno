require 'test_helper'

class SlackNotificationJobTest < ActiveJob::TestCase
  test 'should send slack alert' do
    payload = {
      'channel' => 'bots',
      'username' => 'MyString',
      'text' => 'Foo Bar failing to return a successful status code.'
    }
    stub_request(:post, 'http://foo.bar/')
      .with(body: { 'payload' => payload.to_json })
      .to_return(status: 200)
    SlackNotificationJob.perform_now(sites(:one))
  end

  test 'should fail if no slack settings' do
    refute SlackNotificationJob.perform_now(sites(:two))
  end
end
