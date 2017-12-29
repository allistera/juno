require 'test_helper'

class ProbesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:elton)
    ENV.stubs(:[]).with('JUNO_PROBE_SECRET').returns('FooBar')
  end

  describe '#index' do
    it 'requires authentication' do
      sign_out :user
      get probes_url
      assert_redirected_to new_user_session_url
    end

    it 'returns all probes for platform admins' do
      get probes_url
      assert_response :success
    end

    it 'does not return all probes for users' do
      sign_in users(:joe)
      get probes_url
      assert_redirected_to root_path
    end

    it 'does not return all probes for admins' do
      sign_in users(:paul)
      get probes_url
      assert_redirected_to root_path
    end
  end

  describe '#create' do
    it 'requires shared secret' do
      sign_out :user
      post probes_url, params: { probe: { name: 'Foobar', url: 'https://foo.bar' } }
      assert_response :unauthorized
    end

    it 'creates new probe' do
      assert_difference('Probe.count') do
        post probes_url, params: { probe: {
          name: 'Zigo',
          url: 'https://foo.bar'
        } }, headers: {
          HTTP_AUTHORIZATION: 'Bearer FooBar'
        }
      end

      assert_response :created
    end

    it 'renders bad request on save error' do
      post probes_url, params: { probe: {
        name: 'Zigo'
      } }, headers: {
        HTTP_AUTHORIZATION: 'Bearer FooBar'
      }
      assert_response :bad_request
    end
  end
end
