require 'test_helper'

class ChecksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @check = checks(:one)
    sign_in users(:joe)
  end

  describe '#index' do
    it 'requires authentication' do
      sign_out :user
      get checks_url
      assert_redirected_to new_user_session_url
    end

    it 'returns all checks' do
      get checks_url
      assert_response :success
    end
  end

  describe '#show' do
    it 'requires authentication' do
      sign_out :user
      get check_url(@check)
      assert_redirected_to new_user_session_url
    end

    it 'returns specific checks' do
      get check_url(@check)
      assert_response :success
    end
  end
end
