class Check < ApplicationRecord
  belongs_to :site

  before_create :notification

  private

  def notification
    SlackNotificationJob.perform_later(site, status) if newly_changed?
  end

  def newly_changed?
    return false if site.state == :unknown
    (site.active? && failed?) || (!site.active? && !failed?)
  end

  def failed?
    !status.between?(200, 299)
  end
end
