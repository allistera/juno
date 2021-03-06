# frozen_string_literal: true

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @project = projects(:one)
    sign_in users(:joe)
  end

  describe '#index' do
    it 'requires authentication' do
      sign_out :user
      get projects_url
      assert_redirected_to new_user_session_url
    end

    it 'returns all projects' do
      get projects_url
      assert_response :success
    end

    it 'redirects if user with no organisation' do
      sign_out :user
      sign_in users(:greg)
      get projects_url
      assert_redirected_to new_organisation_url
    end

    it 'does not redirect if admin' do
      sign_out :user
      sign_in users(:paul)
      get projects_url
      assert_response :success
    end
  end

  describe '#new' do
    it 'requires authentication' do
      sign_out :user
      get new_project_url
      assert_redirected_to new_user_session_url
    end

    it 'renders new form' do
      get new_project_url
      assert_response :success
    end
  end

  describe '#create' do
    it 'requires authentication' do
      sign_out :user
      post projects_url, params: { project: { name: 'Foobar' } }
      assert_redirected_to new_user_session_url
    end

    it 'creates new project' do
      assert_difference('Project.count') do
        post projects_url, params: { project: { name: 'Foobar' } }
      end

      assert_redirected_to projects_url
    end

    it 'renders new form on save error' do
      post projects_url, params: { project: { name: '' } }

      assert_template :new
    end

    it 'sets organisation to users' do
      post projects_url, params: { project: { name: 'Teris' } }
      assert_equal 'Peachstones', Project.last.organisation.name
    end
  end

  describe '#destroy' do
    it 'requires authentication' do
      sign_out :user
      delete project_url(@project)
      assert_redirected_to new_user_session_url
    end

    it 'destroys project' do
      ModelDeleteJob.expects(:perform_later).with(@project)

      delete project_url(@project)

      assert_redirected_to projects_url
    end
  end

  describe '#workers_active?' do
    it 'does not display if active checks' do
      get projects_url
      assert_equal false, assigns(:no_checks)
    end

    it 'does not display if no checks' do
      Check.delete_all

      get projects_url
      assert_equal false, assigns(:no_checks)
    end

    it 'displays if no checks in past two mins' do
      Check.delete_all
      Site.delete_all

      site = Site.new(name: 'John',
                      url: 'http://foo.bar',
                      project: projects(:one),
                      created_at: 3.minutes.ago,
                      site_type: 'http')
      Check.create(status: 401, site: site, created_at: 3.minutes.ago)

      get projects_url
      assert_equal true, assigns(:no_checks)
    end
  end
end
