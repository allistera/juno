# frozen_string_literal: true

class ApplicationHelperTest < ActionView::TestCase
  describe '#site_status_class' do
    it 'renders active' do
      assert_equal 'success', site_status_class(sites(:one))
    end

    it 'renders danger' do
      assert_equal 'danger', site_status_class(sites(:two))
    end

    it 'renders unknown' do
      site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
      assert_equal 'default', site_status_class(site)
    end
  end

  describe '#check_status_class' do
    it 'renders active' do
      assert_equal 'tag-success', check_status_class(sites(:one).checks.first)
    end

    it 'renders danger' do
      assert_equal 'tag-danger', check_status_class(sites(:two).checks.first)
    end

    it 'renders unknown' do
      site = Site.create(name: 'John', url: 'http://foo.bar', project: projects(:one))
      check = Check.create(site: site)
      assert_equal 'unknown', check_status_class(check)
    end
  end
end
