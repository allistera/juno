require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @site = sites(:one)
    sign_in users(:joe)
  end

  describe '#index' do
    it 'requires authentication' do
      sign_out :user
      get sites_url
      assert_redirected_to new_user_session_url
    end

    it 'returns all sites' do
      get sites_url
      assert_response :success
    end
  end

  describe '#show' do
    it 'requires authentication' do
      sign_out :user
      get site_url(@site)
      assert_redirected_to new_user_session_url
    end

    it 'returns specific site' do
      get site_url(@site)
      assert_response :success
    end
  end

  describe '#new' do
    it 'requires authentication' do
      sign_out :user
      get new_site_url
      assert_redirected_to new_user_session_url
    end

    it 'renders new form' do
      get new_site_url
      assert_response :success
    end
  end

  describe '#create' do
    it 'requires authentication' do
      sign_out :user
      post sites_url, params: { site: { name: 'Foobar' } }
      assert_redirected_to new_user_session_url
    end

    it 'creates new site' do
      assert_difference('Site.count') do
        post sites_url, params: { site: {
          name: 'Zigo',
          project_id: @site.project_id,
          url: 'foo.bar',
          protocol: 'https://'
        } }
      end

      assert_redirected_to site_url(Site.last)
    end

    it 'renders new form on save error' do
      post sites_url, params: { site: { name: '' } }

      assert_template :new
    end
  end

  describe '#destroy' do
    it 'requires authentication' do
      sign_out :user
      delete site_url(@site)
      assert_redirected_to new_user_session_url
    end

    it 'destroys site' do
      ModelDeleteJob.expects(:perform_later).with(@site)

      delete site_url(@site)

      assert_redirected_to project_url(@site.project)
    end
  end
end
