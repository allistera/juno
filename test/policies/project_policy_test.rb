require 'test_helper'

class ProjectPolicyTest < ActiveSupport::TestCase
  describe 'user' do
    describe 'index' do
      it 'only returns projects belonging to current users organisation' do
        assert_policy_scoped Project.where(organisation: users(:joe).organisation),
                             ProjectPolicy::Scope.new(users(:joe), Project).resolve
      end
    end

    describe 'show' do
      it 'allows if own organisation' do
        assert ProjectPolicy.new(users(:joe), projects(:one)).show?
      end

      it 'rejects if not own organisation' do
        refute ProjectPolicy.new(users(:joe), projects(:two)).show?
      end
    end

    describe 'create' do
      it 'allows if own organisation' do
        assert ProjectPolicy.new(users(:joe), projects(:one)).create?
      end

      it 'rejects if not own organisation' do
        refute ProjectPolicy.new(users(:joe), projects(:two)).create?
      end
    end

    describe 'update' do
      it 'rejects outright' do
        refute ProjectPolicy.new(users(:joe), projects(:one)).update?
      end
    end

    describe 'destroy' do
      it 'allows if own organisation' do
        assert ProjectPolicy.new(users(:joe), projects(:one)).destroy?
      end

      it 'rejects if not own organisation' do
        refute ProjectPolicy.new(users(:joe), projects(:two)).destroy?
      end
    end
  end
end
