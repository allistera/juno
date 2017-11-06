require 'application_system_test_case'

class SitesTest < ApplicationSystemTestCase
  test 'create new site' do
    sign_in users(:joe)
    visit root_path
    click_on 'MyString'

    find('a', text: 'New Site').trigger('click')

    assert_text 'Add Site'
    fill_in 'site[name]', with: 'Google'
    fill_in 'site[url]', with: 'www.google.com'
    click_on 'Create'
    assert_text 'Site was successfully created.'
  end
end
