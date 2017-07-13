require 'test_helper'

class OrganisationPolicyTest < PolicyAssertions::Test

  describe 'admin' do
    describe 'index' do
      it 'returns if admin' do
        assert_policy_scoped Organisation.all,
                             OrganisationPolicy::Scope.new(users(:paul), Organisation).resolve
      end
    end

  end

  describe 'user' do
    describe 'index' do
      it 'rejects outright' do
        refute OrganisationPolicy.new(users(:joe), organisations(:peachstones)).index?
      end
    end

    describe 'show' do
      it 'rejects outright' do
        refute OrganisationPolicy.new(users(:joe), organisations(:peachstones)).show?
      end
    end

    describe 'create' do
      it 'rejects outright' do
        refute OrganisationPolicy.new(users(:joe), organisations(:peachstones)).create?
      end
    end

    describe 'update' do
      it 'rejects outright' do
        refute OrganisationPolicy.new(users(:joe), organisations(:peachstones)).update?
      end
    end

    describe 'destroy' do
      it 'rejects outright' do
        refute OrganisationPolicy.new(users(:joe), organisations(:peachstones)).destroy?
      end
    end
  end
end
