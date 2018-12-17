module ApplicationHelper
  def site_status_class(site)
    return 'default' if site.status == 'unknown'
    return 'success' if site.status == 'active'
    return 'danger' if site.status == 'inactive'
  end

  def check_status_class(check)
    return 'is-success' if check.status == 'active'
    return 'is-danger' if check.status == 'inactive'

    'unknown'
  end

  def current_class?(test_path)
    return 'active' if request.path == test_path

    ''
  end
end
