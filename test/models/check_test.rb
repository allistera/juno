require 'test_helper'

class CheckTest < ActiveSupport::TestCase
  test 'valid check' do
    check = Check.new(status: 401, site: sites(:one))
    assert check.valid?
  end

  test 'invalid without site' do
    check = Check.new(status: 401)
    refute check.valid?, 'check is valid without a site'
    assert_not_nil check.errors[:site], 'no validation error for site present'
  end
end
