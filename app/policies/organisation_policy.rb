class OrganisationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user.admin
      scope.all
    end
  end

  def index?
    user.admin
  end

  def show?
    user.admin
  end

  def create?
    user.admin
  end

  def new?
    user.admin
  end

  def update?
    user.admin
  end

  def destroy?
    user.admin
  end
end
