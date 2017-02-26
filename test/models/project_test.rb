require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'valid project' do
    project = Project.new(name: 'John')
    assert project.valid?
  end

  test 'invalid without name' do
    project = Project.new
    refute project.valid?, 'project is valid without a name'
    assert_not_nil project.errors[:name], 'no validation error for name present'
  end
end
