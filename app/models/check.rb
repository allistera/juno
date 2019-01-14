# frozen_string_literal: true

class Check < ApplicationRecord
  belongs_to :site

  def state
    return http_state if site.site_type == 'http'
    return ping_state if site.site_type == 'ping'
  end

  private

  def http_state
    if site.custom_status && status.to_i == site.custom_status
      'active'
    elsif status.to_i.between?(200, 299)
      'active'
    else
      'inactive'
    end
  end

  def ping_state
    if status == 1
      'active'
    else
      'inactive'
    end
  end
end
