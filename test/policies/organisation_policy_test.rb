# frozen_string_literal: true

require 'test_helper'

class OrganisationPolicyTest < PolicyAssertions::Test
  describe 'admin' do
    describe 'index' do
      it 'returns if admin' do
        assert_policy_scoped Organisation.all,
                             OrganisationPolicy::Scope.new(users(:elton), Organisation).resolve
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

    describe 'new' do
      it 'public' do
        assert OrganisationPolicy.new(users(:joe), organisations(:peachstones)).new?
      end
    end

    describe 'create' do
      it 'public' do
        assert OrganisationPolicy.new(users(:joe), organisations(:peachstones)).create?
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
