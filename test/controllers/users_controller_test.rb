require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:paul)
    sign_in users(:paul)
  end

  describe '#index' do
    it 'requires authentication' do
      sign_out :user
      get users_url
      assert_redirected_to new_user_session_url
    end

    it 'returns all users' do
      get users_url
      assert_response :success
    end
  end

  describe '#new' do
    it 'requires authentication' do
      sign_out :user
      get new_user_url
      assert_redirected_to new_user_session_url
    end

    it 'renders new form' do
      get new_user_url
      assert_response :success
    end
  end

  describe '#destroy' do
    it 'requires authentication' do
      sign_out :user
      delete user_url(@user)
      assert_redirected_to new_user_session_url
    end

    it 'destroys user' do
      assert_difference('User.count', -1) do
        delete user_url(@user)
      end

      assert_redirected_to users_url
    end
  end
end
