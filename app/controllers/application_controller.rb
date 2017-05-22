class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :workers_active?

  private

  def workers_active?
    sites = Site.where('created_at <= ?', 2.minutes.ago).count
    checks = Check.where('created_at >= ?', 2.minutes.ago).count
    @no_checks = !sites.zero? && checks.zero?
  end
end
