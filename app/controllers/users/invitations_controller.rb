# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters, if: :devise_controller?
    def invite_params
      super.merge(organisation_id: current_user.organisation.id)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:invite, keys: [:name])
    end
  end
end
