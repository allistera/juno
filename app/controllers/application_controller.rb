class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :workers_active?

  after_action :verify_authorized, except: :index, unless: proc { controller_name == 'sessions' }
  after_action :verify_policy_scoped, only: :index

  private

  def workers_active?
    sites = Site.where('created_at <= ?', 2.minutes.ago).count
    checks = Check.where('created_at >= ?', 2.minutes.ago).count
    @no_checks = !sites.zero? && checks.zero?
  end
end
