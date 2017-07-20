module Users
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:invite, keys: [:organisation_id])
    end
  end
end
