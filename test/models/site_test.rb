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
end
