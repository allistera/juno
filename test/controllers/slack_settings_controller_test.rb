require 'test_helper'

class SlackSettingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @slack_setting = slack_settings(:one)
    sign_in users(:joe)
  end

  describe '#show' do
    it 'requires authentication' do
      sign_out :user
      get slack_setting_url(@slack_setting)
      assert_redirected_to new_user_session_url
    end

    it 'returns specific slack setting' do
      get slack_setting_url(@slack_setting)
      assert_response :success
    end
  end

  describe '#new' do
    it 'requires authentication' do
      sign_out :user
      get new_slack_setting_url
      assert_redirected_to new_user_session_url
    end

    it 'renders new form' do
      get new_slack_setting_url
      assert_response :success
    end
  end

  describe '#create' do
    it 'requires authentication' do
      sign_out :user
      post slack_settings_url
      assert_redirected_to new_user_session_url
    end

    it 'creates new slack setting' do
      assert_difference('SlackSetting.count') do
        post slack_settings_url, params: {
          slack_setting: {
            channel: @slack_setting.channel,
            project_id: @slack_setting.project_id,
            username: @slack_setting.username,
            webhook_url: @slack_setting.webhook_url
          }
        }
      end

      assert_redirected_to project_url(SlackSetting.last.project)
    end

    it 'renders new form on save error' do
      post slack_settings_url, params: { slack_setting: { channel: '', project_id: projects(:one).id } }

      assert_template :new
    end
  end

  describe '#update' do
    it 'requires authentication' do
      sign_out :user
      patch slack_setting_url(@slack_setting)
      assert_redirected_to new_user_session_url
    end

    it 'creates update slack setting' do
      patch slack_setting_url(@slack_setting), params: {
        slack_setting: {
          channel: @slack_setting.channel,
          project_id: @slack_setting.project_id,
          username: @slack_setting.username,
          webhook_url: @slack_setting.webhook_url
        }
      }
      assert_redirected_to project_url(@slack_setting.project)
    end

    it 'renders edit form on save error' do
      patch slack_setting_url(@slack_setting), params: {
        slack_setting: { webhook_url: '',
                         project_id: @slack_setting.project_id }
      }

      assert_template :edit
    end
  end

  describe '#destroy' do
    it 'requires authentication' do
      sign_out :user
      delete slack_setting_url(@slack_setting)
      assert_redirected_to new_user_session_url
    end

    it 'destroys slack setting' do
      assert_difference('SlackSetting.count', -1) do
        delete slack_setting_url(@slack_setting)
      end

      assert_redirected_to project_url(@slack_setting.project)
    end
  end
end
