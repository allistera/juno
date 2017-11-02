require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'signing up' do
    visit root_path

    assert_text 'You need to sign in or sign up before continuing'

    click_on 'Sign Up'

    assert_text 'Sign Up'

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'SecUr3Pa33W0rD!'
    fill_in 'user_password_confirmation', with: 'SecUr3Pa33W0rD!'

    click_on 'Next'

    assert_text 'User was successfully created, please login.'

    fill_in 'user_email', with: 'foo@bar.com'
    fill_in 'user_password', with: 'SecUr3Pa33W0rD!'

    click_on 'Log in'

    assert_text 'Signed in successfully'
    assert_text 'Create Organisation'

    fill_in 'organisation_name', with: 'OrgTest AA'
    click_on 'Save'

    assert_text 'Projects'
    assert_text 'Users'
  end

  test 'administrator can invite additional user' do
    sign_in users(:paul)
    visit root_path

    click_on 'Users'
    click_on 'Invite User'

    assert_text 'Send invitation'

    fill_in 'user_email', with: 'zoo@bar.com'

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      click_on 'Invite'
    end
    invite_email = ActionMailer::Base.deliveries.last

    assert_equal 'Invitation instructions', invite_email.subject
    assert_equal 'zoo@bar.com', invite_email.to[0]
  end
end
