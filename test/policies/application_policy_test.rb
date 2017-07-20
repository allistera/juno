require 'test_helper'

class ApplicationPolicyTest < ActiveSupport::TestCase
  describe 'index' do
    it 'rejects outright' do
      refute ApplicationPolicy.new(users(:joe), User).index?
    end
  end

  describe 'show' do
    it 'rejects outright' do
      refute ApplicationPolicy.new(users(:joe), User).show?
    end
  end

  describe 'new' do
    it 'rejects outright' do
      refute ApplicationPolicy.new(users(:joe), User).new?
    end
  end

  describe 'create' do
    it 'rejects outright' do
      refute ApplicationPolicy.new(users(:joe), User).create?
    end
  end

  describe 'edit' do
    it 'rejects outright' do
      refute ApplicationPolicy.new(users(:joe), User).edit?
    end
  end

  describe 'update' do
    it 'rejects outright' do
      refute ApplicationPolicy.new(users(:joe), User).update?
    end
  end

  describe 'destroy' do
    it 'rejects outright' do
      refute ApplicationPolicy.new(users(:joe), User).destroy?
    end
  end
end
