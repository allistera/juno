class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(organisation: user.organisation)
    end
  end

  def show?
    record.organisation == user.organisation
  end

  def create?
    record.organisation == user.organisation
  end

  def new?
    true
  end

  def destroy?
    record.organisation == user.organisation
  end
end
