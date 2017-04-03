class ApplicationHelperTest < ActionView::TestCase
  test 'site_status_class active' do
    assert_equal 'is-success', site_status_class(sites(:one))
  end

  test 'site_status_class inactive' do
    assert_equal 'is-danger', site_status_class(sites(:two))
  end

  test 'site_status_class unknown' do
    site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
    assert_equal 'is-light', site_status_class(site)
  end
end
