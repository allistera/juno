class ProbePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user.platform_admin
      scope.all
    end
  end

  def index?
    user.platform_admin
  end

  def create?
    true
  end
end
