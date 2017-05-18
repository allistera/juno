class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :workers_active?

  private

  def workers_active?
    @no_checks = Site.count > 0 && Check.where('created_at >= ?', 2.minutes.ago).count.zero?
  end
end
