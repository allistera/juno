module ApplicationHelper
  def site_status_class(site)
    return 'is-light' if site.status == 'unknown'
    return 'is-success' if site.status == 'active'
    return 'is-danger' if site.status == 'inactive'
  end

  def check_status_class(check)
    return 'is-success' if check.state == 'active'
    return 'is-danger' if check.state == 'inactive'
    'unknown'
  end
end
