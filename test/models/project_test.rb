require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'valid project' do
    project = Project.new(name: 'John', organisation: organisations(:berryware))
    assert project.valid?
  end

  test 'invalid without name' do
    project = Project.new(organisation: organisations(:berryware))
    refute project.valid?, 'project is valid without a name'
    assert_not_nil project.errors[:name], 'no validation error for name present'
  end

  test 'name must be unique to organisation' do
    project = Project.new(name: 'MyString2', organisation: organisations(:berryware))
    refute project.valid?, 'project is valid without a unique name'
    assert_not_nil project.errors[:name], 'no validation error for name present'
  end

  test 'name does not need to be unique across organisations' do
    project = Project.new(name: 'MyString', organisation: organisations(:berryware))
    assert project.valid?
  end

  test 'must belong to an organisation' do
    project = Project.new(name: 'John')
    refute project.valid?, 'project is valid without a organisation'
    assert_not_nil project.errors[:organisation], 'no validation error for organisation present'
  end
end
