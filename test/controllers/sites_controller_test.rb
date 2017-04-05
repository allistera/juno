require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @site = sites(:one)
    sign_in users(:joe)
  end

  test 'should be authenticated' do
    sign_out :user

    get checks_url
    assert_redirected_to new_user_session_url
  end

  test 'should get index' do
    get sites_url
    assert_response :success
  end

  test 'should get new' do
    get new_site_url
    assert_response :success
  end

  test 'should create site' do
    assert_difference('Site.count') do
      post sites_url, params: { site: { name: 'Zigo', project_id: @site.project_id, url: @site.url } }
    end

    assert_redirected_to site_url(Site.last)
  end

  test 'should show site' do
    get site_url(@site)
    assert_response :success
  end

  test 'should get edit' do
    get edit_site_url(@site)
    assert_response :success
  end

  test 'should update site' do
    patch site_url(@site), params: { site: { name: @site.name, project_id: @site.project_id, url: @site.url } }
    assert_redirected_to site_url(@site)
  end

  test 'should destroy site' do
    assert_difference('Site.count', -1) do
      delete site_url(@site)
    end

    assert_redirected_to project_url(@site.project)
  end
end
