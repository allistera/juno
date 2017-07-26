class SlackSettingPolicy < ApplicationPolicy
  def show?
    record.project.organisation == user.organisation
  end

  def create?
    record.project.organisation == user.organisation
  end

  def new?
    true
  end

  def edit?
    record.project.organisation == user.organisation
  end

  def update?
    record.project.organisation == user.organisation
  end

  def destroy?
    record.project.organisation == user.organisation
  end
end
