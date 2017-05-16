require 'test_helper'

class HttpCheckJobTest < ActiveJob::TestCase
  test 'should check all sites' do
    stub_request(:get, 'https://test.com/').to_return(status: 200)

    HttpCheckJob.perform_now(sites(:two))

    assert_equal 200, Check.last.status
  end

  test 'should check twice if first fails' do
    stub_request(:get, 'http://foo.bar/').to_return(status: 501)
    stub_request(:get, 'http://foo.bar/').to_return(status: 501)

    HttpCheckJob.perform_now(sites(:one))

    assert_equal 501, Check.last.status
  end

  test 'should check twice if first fails for a custom status' do
    stub_request(:get, 'https://test2.com/').to_return(status: 501)
    stub_request(:get, 'https://test2.com/').to_return(status: 501)

    HttpCheckJob.perform_now(sites(:three))

    assert_equal 501, Check.last.status
  end
end
