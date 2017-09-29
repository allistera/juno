require 'test_helper'

class OrganisationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @organisation = organisations(:peachstones)
    sign_in users(:paul)
  end

  describe '#index' do
    it 'requires authentication' do
      sign_out :user
      get organisations_url
      assert_redirected_to new_user_session_url
    end

    it 'returns all organisations for admins' do
      get organisations_url
      assert_response :success
    end

    it 'does not return all organisations for users' do
      sign_in users(:joe)
      get organisations_url
      assert_redirected_to root_path
    end
  end

  describe '#new' do
    it 'requires authentication' do
      sign_out :user
      get new_organisation_url
      assert_redirected_to new_user_session_url
    end

    it 'renders new form' do
      get new_organisation_url
      assert_response :success
    end
  end

  describe '#create' do
    it 'requires authentication' do
      sign_out :user
      post organisations_url, params: { organisation: { name: 'Foobar' } }
      assert_redirected_to new_user_session_url
    end

    it 'creates new site' do
      assert_difference('Organisation.count') do
        post organisations_url, params: { organisation: {
          name: 'Zigo'
        } }
      end

      assert_redirected_to root_path
    end

    it 'renders new form on save error' do
      post organisations_url, params: { organisation: { name: '' } }

      assert_template :new
    end

    it 'assigns user to new organisation' do
      sign_in users(:joe)

      assert_difference('Organisation.count') do
        post organisations_url, params: { organisation: {
          name: 'Boo!'
        } }
      end

      assert_equal users(:joe).organisation.name, 'Boo!'
    end
  end

  describe '#destroy' do
    it 'requires authentication' do
      sign_out :user
      delete organisation_url(@organisation)
      assert_redirected_to new_user_session_url
    end

    it 'allows admins to destroys organisation' do
      ModelDeleteJob.expects(:perform_later).with(@organisation)

      delete organisation_url(@organisation)

      assert_redirected_to organisations_url
    end

    it 'rejects standard users destroying organisation' do
      sign_in users(:joe)
      delete organisation_url(@organisation)
      assert_redirected_to root_url
    end
  end
end
