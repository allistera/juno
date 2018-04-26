require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'signing up' do
    visit root_path

    assert_text 'You need to sign in or sign up before continuing'

    click_on 'Sign up'

    assert_text 'Create new account'

    fill_in 'user_name', with: 'Johnny Cash'
    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'SecUr3Pa33W0rD!'
    find('#user_terms_and_conditions', visible: false).trigger('click')

    click_on 'Create'

    assert_text 'User was successfully created, please login.'

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'SecUr3Pa33W0rD!'

    click_on 'Sign in'

    assert_text 'Signed in successfully'
    assert_text 'Create Organisation'

    fill_in 'organisation_name', with: 'OrgTest AA'
    click_on 'Save'
  end

  test 'administrator can invite additional user' do
    sign_in users(:paul)
    visit users_path

    click_on 'Invite User'
    first('.btn-primary').click

    fill_in 'user_email', with: 'zoo@bar.com'

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      click_on 'Save'
    end
    invite_email = ActionMailer::Base.deliveries.last

    assert_equal 'Invitation instructions', invite_email.subject
    assert_equal 'zoo@bar.com', invite_email.to[0]
  end
end
