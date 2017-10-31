module Users
  class InvitationsController < Devise::InvitationsController
    def invite_params
      super.merge(organisation_id: current_user.organisation.id)
    end
  end
end
