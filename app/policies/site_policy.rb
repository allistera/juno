# frozen_string_literal: true

class SitePolicy < ApplicationPolicy
  def show?
    record.project.organisation == user.organisation
  end

  def create?
    record.project.organisation == user.organisation
  end

  def new?
    true
  end

  def destroy?
    record.project.organisation == user.organisation
  end

  def checks?
    record.project.organisation == user.organisation
  end
end
