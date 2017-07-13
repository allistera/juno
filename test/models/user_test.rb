require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user requires organisation' do
    user = User.new(email: 'foo@bar.com', password: '1110009', password_confirmation: '1110009')
    refute user.valid?
  end

  test 'admin does not require organisation' do
    user = User.new(email: 'foo@bar.com', password: '1110009', password_confirmation: '1110009', admin: true)
    assert user.valid?
  end
end
