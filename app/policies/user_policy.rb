# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.platform_admin
        scope.all
      elsif user.admin
        scope.where(organisation: user.organisation)
      else
        raise Pundit::NotAuthorizedError, 'must be logged in'
      end
    end
  end

  def index?
    user.platform_admin || user.admin
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
