# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  test 'create new project and configure slack' do
    sign_in users(:paul)
    visit root_path
    first('#new_project').click

    assert_text 'Creating Project'
    fill_in 'project_name', with: 'Production'
    click_on 'Save'
    assert_text 'Project was successfully created.'

    first('.slack_settings').click

    assert_text 'Slack Settings'
    fill_in 'slack_setting_webhook_url', with: 'https://foo.bar.com/e3wewe'
    fill_in 'slack_setting_channel', with: '#test'
    fill_in 'slack_setting_username', with: 'mybot'
    click_on 'Save'
    assert_text 'Slack settings where successfully updated.'
  end
end
