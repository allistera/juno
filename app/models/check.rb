class Check < ApplicationRecord
  belongs_to :site

  before_create :notification

  private

  def notification
    SlackNotificationJob.perform_later(site, status) if newly_failed?
  end

  def newly_failed?
    return false if status.between?(200, 299)
    site.active?
  end
end
