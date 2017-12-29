require 'test_helper'

class ProbePolicyTest < PolicyAssertions::Test
  describe 'admin' do
    describe 'index' do
      it 'returns if admin' do
        assert_policy_scoped Probe.all,
                             ProbePolicy::Scope.new(users(:elton), Probe).resolve
      end
    end
  end

  describe 'user' do
    describe 'index' do
      it 'rejects outright' do
        refute ProbePolicy.new(users(:joe), organisations(:peachstones)).index?
      end
    end

    describe 'show' do
      it 'rejects outright' do
        refute ProbePolicy.new(users(:joe), organisations(:peachstones)).show?
      end
    end

    describe 'new' do
      it 'rejects outright' do
        refute ProbePolicy.new(users(:joe), organisations(:peachstones)).new?
      end
    end

    describe 'create' do
      it 'public' do
        assert ProbePolicy.new(users(:joe), organisations(:peachstones)).create?
      end
    end

    describe 'update' do
      it 'rejects outright' do
        refute ProbePolicy.new(users(:joe), organisations(:peachstones)).update?
      end
    end

    describe 'destroy' do
      it 'rejects outright' do
        refute ProbePolicy.new(users(:joe), organisations(:peachstones)).destroy?
      end
    end
  end
end
