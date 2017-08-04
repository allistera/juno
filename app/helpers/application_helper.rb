module ApplicationHelper
  def site_status_class(site)
    return 'is-light' if site.status == 'unknown'
    return 'is-success' if site.status == 'active'
    return 'is-danger' if site.status == 'inactive'
  end
end
