require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
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

    describe 'create' do
      it 'rejects outright' do
        refute UserPolicy.new(users(:joe), users(:paul)).create?
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
end
