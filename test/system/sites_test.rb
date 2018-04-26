require 'application_system_test_case'

class SitesTest < ApplicationSystemTestCase
  test 'create new site' do
    sign_in users(:joe)
    visit root_path

    first('.new_site').click

    assert_text 'Create Check'
    fill_in 'site[name]', with: 'Google'
    fill_in 'site[url]', with: 'www.google.com'
    click_on 'Save'
    assert_text 'Site was successfully created.'
  end
end
