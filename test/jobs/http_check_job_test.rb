require 'test_helper'

class HttpCheckJobTest < ActiveJob::TestCase
  test 'should check all sites' do
    stub_request(:get, 'https://test.com/').to_return(status: 200)
    stub_request(:get, 'https://foo.bar/').to_return(status: 200)

    HttpCheckJob.perform_now
  end
end
