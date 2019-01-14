# frozen_string_literal: true

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

  test 'state is active' do
    check = Check.new(status: 201, site: sites(:one))
    assert_equal 'active', check.state
  end

  test 'state is active for custom codes' do
    check = Check.new(status: 301, site: sites(:three))
    assert_equal 'active', check.state
  end

  test 'state is inactive' do
    check = Check.new(status: 501, site: sites(:one))
    assert_equal 'inactive', check.state
  end

  test 'ping request state is active' do
    check = Check.new(status: 1, site: sites(:ping_site))
    assert_equal 'active', check.state
  end

  test 'ping request state is inactive' do
    check = Check.new(status: 0, site: sites(:ping_site))
    assert_equal 'inactive', check.state
  end
end
