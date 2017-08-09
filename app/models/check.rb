class Check < ApplicationRecord
  belongs_to :site

  def state
    if site.custom_status && status.to_i == site.custom_status
      'active'
    elsif status.to_i.between?(200, 299)
      'active'
    else
      'inactive'
    end
  end
end
