# frozen_string_literal: true

module ApplicationHelper
  def site_status_class(site)
    return 'default' if site.status == 'unknown'
    return 'success' if site.status == 'active'
    return 'danger' if site.status == 'inactive'
  end

  def check_status_class(check)
    return 'tag-success' if check.state == 'active'
    return 'tag-danger' if check.state == 'inactive'

    'unknown'
  end

  def current_class?(test_path)
    return 'active' if request.path == test_path

    ''
  end
end
