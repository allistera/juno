require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  describe 'index' do
    it 'returns all if platform admin' do
      assert_policy_scoped User.all,
                           UserPolicy::Scope.new(users(:elton), User).resolve
    end

    it 'returns all in organisation admin' do
      assert_policy_scoped User.where(organisation: users(:paul).organisation),
                           UserPolicy::Scope.new(users(:paul), User).resolve
    end
  end

  describe 'user' do
    describe 'index' do
      it 'rejects outright' do
        refute UserPolicy.new(users(:joe), User).index?
      end
    end

    describe 'show' do
      it 'rejects outright' do
        refute UserPolicy.new(users(:joe), users(:paul)).show?
      end
    end

    describe 'new' do
      it 'allows' do
        assert UserPolicy.new(users(:joe), users(:paul)).new?
      end
    end

    describe 'create' do
      it 'allows' do
        assert UserPolicy.new(users(:joe), users(:paul)).create?
      end
    end

    describe 'update' do
      it 'rejects outright' do
        refute UserPolicy.new(users(:joe), users(:paul)).update?
      end
    end

    describe 'destroy' do
      it 'rejects outright' do
        refute UserPolicy.new(users(:joe), users(:paul)).destroy?
      end
    end
  end

  describe 'admin' do
    describe 'index' do
      it 'allows' do
        assert UserPolicy.new(users(:paul), User).index?
      end
    end

    describe 'show' do
      it 'rejects' do
        refute UserPolicy.new(users(:paul), users(:joe)).show?
      end
    end

    describe 'new' do
      it 'allows' do
        assert UserPolicy.new(users(:joe), users(:paul)).new?
      end
    end

    describe 'create' do
      it 'allows' do
        assert UserPolicy.new(users(:joe), users(:paul)).create?
      end
    end

    describe 'update' do
      it 'rejects' do
        refute UserPolicy.new(users(:paul), users(:joe)).update?
      end
    end

    describe 'destroy' do
      it 'rejects if in organisation' do
        assert UserPolicy.new(users(:elton), users(:joe)).destroy?
      end

      it 'rejects if outwith organisation' do
        refute UserPolicy.new(users(:paul), users(:joe)).destroy?
      end
    end
  end
end
