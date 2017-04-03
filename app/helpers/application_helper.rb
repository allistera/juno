module ApplicationHelper
  def site_status_class(site)
    return 'is-light' if site.state == :unknown
    return 'is-success' if site.state == :active
    return 'is-danger' if site.state == :inactive
  end
end
