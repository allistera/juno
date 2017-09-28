class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :workers_active?
  before_action :organisation_exist?, unless: proc {
    !current_user || controller_name == 'sessions' || controller_name == 'invitations'
  }

  after_action :verify_authorized, except: :index, unless: proc {
    controller_name == 'sessions' || controller_name == 'invitations'
  }
  after_action :verify_policy_scoped, only: :index

  private

  def workers_active?
    sites = Site.where('created_at <= ?', 2.minutes.ago).count
    checks = Check.where('created_at >= ?', 2.minutes.ago).count
    @no_checks = !sites.zero? && checks.zero?
  end

  def organisation_exist?
    return if controller_name == 'organisations' && (action_name == 'new' || action_name == 'create')
    redirect_to new_organisation_path unless current_user.organisation || current_user.admin
  end
end
