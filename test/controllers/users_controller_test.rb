require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:elton)
    sign_in users(:elton)
  end

  describe '#index' do
    it 'requires authentication' do
      sign_out :user
      get users_url
      assert_redirected_to new_user_session_url
    end

    it 'rejects non admins' do
      sign_in users(:joe)
      get users_url
      assert_redirected_to root_url
    end

    it 'returns all users' do
      get users_url
      assert_response :success
    end
  end

  describe '#show' do
    it 'requires authentication' do
      sign_out :user
      get user_url(@user)
      assert_redirected_to new_user_session_url
    end

    it 'rejects non admins' do
      sign_in users(:joe)
      get user_url(@user)
      assert_redirected_to root_url
    end

    it 'returns user' do
      get user_url(@user)
      assert_response :success
    end
  end

  describe '#new' do
    it 'renders new form' do
      get new_user_url
      assert_response :success
    end
  end

  describe '#create' do
    it 'creates new user' do
      assert_difference('User.count') do
        post users_url, params: {
          user: {\
            name: 'Foo Bar',
            email: 'foo@gmail.com',
            password: 'FooBar!',
            password_confirmation: 'FooBar!'
          }
        }
      end

      assert_redirected_to new_user_session_url
    end

    it 'renders new form on save error' do
      post users_url, params: { user: { email: '', password: '', password_confirmation: 'a' } }

      assert_template :new
    end
  end

  describe '#update' do
    it 'requires authentication' do
      sign_out :user
      patch user_url(@user)
      assert_redirected_to new_user_session_url
    end

    it 'creates update user' do
      patch user_url(@user), params: {
        user: {
          name: 'foo bar',
          email: 'foo@bar.com',
          organisation_id: organisations(:peachstones),
          admin: false
        }
      }
      assert_redirected_to users_url
    end

    it 'renders edit form on save error' do
      patch user_url(@user), params: {
        user: { email: '' }
      }

      assert_template :show
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
