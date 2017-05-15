require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  test 'valid site' do
    site = Site.new(name: 'John', url: 'http://foo.bar', project: projects(:one))
    site.valid?
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

  test 'url must be valid address' do
    site = Site.new(name: 'John', url: 'bar', project: projects(:one))
    refute site.valid?
    assert_not_nil site.errors[:url]
  end

  test 'name must be unique to project' do
    site = Site.new(name: 'Foo Bar', url: 'http://foo.bar', project: projects(:one))
    refute site.valid?
    assert_not_nil site.errors[:name]
  end

  test 'name can be used in diffrent projects' do
    site = Site.new(name: 'Foo Bar', url: 'http://foo.bar', project: projects(:two))
    assert site.valid?
  end

  test 'uptime returns nil if no checks' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
    assert_nil site.uptime
  end

  test 'uptime returns 100 if all checks have succeeded' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
    Check.create(status: 201, site: site, time: 100)
    assert_equal 100, site.uptime
  end

  test 'uptime returns correct percentage' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
    Check.create(status: 201, site: site, time: 100)
    Check.create(status: 501, site: site, time: 100)
    Check.create(status: 201, site: site, time: 100)

    assert_equal 66.67, site.uptime
  end

  test 'last_downtime returns last failed check time' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
    Check.create(status: 501, site: site, time: 100)
    check = Check.create(status: 501, site: site, time: 100)

    assert_in_delta check.created_at, site.last_downtime
  end

  test 'last_downtime returns nil if no downtime' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
    Check.create(status: 201, site: site, time: 100)

    assert_nil site.last_downtime
  end

  test 'last_downtime returns nil if no checks' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))

    assert_nil site.last_downtime
  end

  test 'custom_status allowed' do
    site = Site.new(name: 'John', url: 'http://foo.bar', project: projects(:one), custom_status: 205)
    assert site.valid?
  end

  test 'custom_status must be higher than 99' do
    site = Site.new(name: 'John', url: 'http://foo.bar', project: projects(:one), custom_status: 42)
    refute site.valid?
    assert_not_nil site.errors[:custom_status]
  end

  test 'custom_status must be less than 528' do
    site = Site.new(name: 'John', url: 'http://foo.bar', project: projects(:one), custom_status: 528)
    refute site.valid?
    assert_not_nil site.errors[:custom_status]
  end
end
