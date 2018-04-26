require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'does not require organisation' do
    user = User.new(name: 'foo',
                    email: 'foo@bar.com',
                    password: '1110009',
                    password_confirmation: '1110009',
                    terms_and_conditions: 'yes')
    assert user.valid?
  end

  test 'user can be admin' do
    user = User.new(name: 'foo',
                    email: 'foo@bar.com',
                    password: '1110009',
                    password_confirmation: '1110009',
                    admin: true,
                    terms_and_conditions: 'yes')
    assert user.valid?
  end

  test 'requires name' do
    user = User.new(email: 'foo@bar.com',
                    password: '1110009',
                    password_confirmation: '1110009',
                    admin: true)
    refute user.valid?
  end

  test 'requires terms and conditions to create' do
    user = User.new(name: 'foo',
                    email: 'foo@bar.com',
                    password: '1110009',
                    password_confirmation: '1110009',
                    terms_and_conditions: 'no')
    refute user.valid?
  end
end
