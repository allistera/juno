require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  test 'valid site' do
    site = Site.new(name: 'John', url: 'http://foo.bar', project: projects(:one))
    assert site.valid?
  end

  test 'invalid without name' do
    site = Site.new(url: 'http://foo.bar', project: projects(:one))
    refute site.valid?, 'site is valid without a name'
    assert_not_nil site.errors[:name], 'no validation error for name present'
  end

  test 'invalid without url' do
    site = Site.new(name: 'John', project: projects(:one))
    refute site.valid?, 'site is valid without a url'
    assert_not_nil site.errors[:url], 'no validation error for url present'
  end

  test 'invalid without project' do
    site = Site.new(name: 'John', url: 'http://foo.bar')
    refute site.valid?, 'site is valid without a project'
    assert_not_nil site.errors[:project], 'no validation error for project present'
  end

  test 'inactive if no checks' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
    refute site.active?
  end

  test 'inactive if last check is 500' do
    site = sites(:two)
    refute site.active?
  end

  test 'active if last check is 201' do
    site = sites(:one)
    assert site.active?
  end

  test 'state is active' do
    site = sites(:one)
    assert_equal :active, site.state
  end

  test 'state is inactive' do
    site = sites(:two)
    assert_equal :inactive, site.state
  end

  test 'state is unknown by default' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
    assert_equal :unknown, site.state
  end
end
