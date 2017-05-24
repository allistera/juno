require 'test_helper'

class HttpCheckJobTest < ActiveJob::TestCase
  describe '#perform_now' do
    it 'checks all sites' do
      stub_request(:get, 'https://test.com/').to_return(status: 200)

      HttpCheckJob.perform_now(sites(:two))

      assert_equal 200, Check.last.status
    end

    it 'checks twice if first fails' do
      stub_request(:get, 'http://foo.bar/').to_return(status: 501)
      stub_request(:get, 'http://foo.bar/').to_return(status: 501)

      HttpCheckJob.perform_now(sites(:one))

      assert_equal 501, Check.last.status
    end

    it 'checks twice if first fails for a custom status' do
      stub_request(:get, 'https://test2.com/').to_return(status: 501)
      stub_request(:get, 'https://test2.com/').to_return(status: 501)

      HttpCheckJob.perform_now(sites(:three))

      assert_equal 501, Check.last.status
    end

    it 'returns nil on HTTParty::ResponseError exception' do
      stub_request(:get, 'https://test2.com/').to_raise(HTTParty::ResponseError)
      stub_request(:get, 'https://test2.com/').to_raise(HTTParty::ResponseError)

      HttpCheckJob.perform_now(sites(:three))

      assert_nil Check.last.status
    end

    it 'returns nil on SocketError exception' do
      stub_request(:get, 'https://test2.com/').to_raise(SocketError)
      stub_request(:get, 'https://test2.com/').to_raise(SocketError)

      HttpCheckJob.perform_now(sites(:three))

      assert_nil Check.last.status
    end
  end
end
