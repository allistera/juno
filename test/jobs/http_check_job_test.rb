# frozen_string_literal: true

require 'test_helper'

class HttpCheckJobTest < ActiveJob::TestCase
  describe '#perform_now' do
    setup do
      ENV.stubs(:[]).with('JUNO_PROBE_SECRET').returns('FooBar')
    end

    it 'checks site' do
      submitted_payload = {
        url: 'https://test.com',
        verify_ssl: false,
        basic_auth: {
          username: nil,
          password: nil
        }
      }
      returned_payload = {
        'Result' => {
          'StatusCode' => 200,
          'ResponseTime' => 12_121_212
        }
      }
      stub_request(:post, 'http://eu.local/v1/request')
        .to_return(status: 200, body: returned_payload.to_json)
        .with(body: submitted_payload.to_json,
              headers: { 'Authorization' => 'Bearer FooBar' })

      HttpCheckJob.perform_now(sites(:two))

      assert_equal 200, Check.last.status
      assert_equal 12_121_212, Check.last.time
    end

    it 'supports custom status' do
      submitted_payload = {
        url: 'https://test2.com',
        verify_ssl: true,
        basic_auth: {
          username: nil,
          password: nil
        }
      }
      returned_payload = {
        'Result' => {
          'StatusCode' => 501,
          'ResponseTime' => 12_121_212
        }
      }
      stub_request(:post, 'http://eu.local/v1/request')
        .to_return(status: 200, body: returned_payload.to_json)
        .with(body: submitted_payload.to_json,
              headers: { 'Authorization' => 'Bearer FooBar' })

      HttpCheckJob.perform_now(sites(:three))

      assert_equal 501, Check.last.status
      assert_equal 12_121_212, Check.last.time
    end

    it 'returns nil on HTTParty::ResponseError exception' do
      stub_request(:post, 'http://eu.local/v1/request')
        .to_raise(HTTParty::ResponseError)

      HttpCheckJob.perform_now(sites(:two))

      assert_nil Check.last.status
      assert_nil Check.last.time
    end

    it 'returns nil on SocketError exception' do
      stub_request(:post, 'http://eu.local/v1/request')
        .to_raise(SocketError)

      HttpCheckJob.perform_now(sites(:two))

      assert_nil Check.last.status
      assert_nil Check.last.time
    end

    it 'supports basic auth' do
      submitted_payload = {
        url: 'http://foo.bar',
        verify_ssl: true,
        basic_auth: {
          username: 'foo',
          password: 'bar'
        }
      }
      returned_payload = {
        'Result' => {
          'StatusCode' => 200,
          'ResponseTime' => 12_121_212
        }
      }
      stub_request(:post, 'http://eu.local/v1/request')
        .to_return(status: 200, body: returned_payload.to_json)
        .with(body: submitted_payload.to_json,
              headers: { 'Authorization' => 'Bearer FooBar' })

      HttpCheckJob.perform_now(sites(:basic_auth))

      assert_equal 200, Check.last.status
    end
  end
end
