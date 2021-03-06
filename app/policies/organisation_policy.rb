# frozen_string_literal: true

class OrganisationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user.platform_admin

      scope.all
    end
  end

  def index?
    user.platform_admin
  end

  def show?
    user.platform_admin
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    user.platform_admin
  end

  def destroy?
    user.platform_admin
  end
end
