require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'does not require organisation' do
    user = User.new(email: 'foo@bar.com', password: '1110009', password_confirmation: '1110009')
    assert user.valid?
  end

  test 'user can be admin' do
    user = User.new(email: 'foo@bar.com', password: '1110009', password_confirmation: '1110009', admin: true)
    assert user.valid?
  end
end
