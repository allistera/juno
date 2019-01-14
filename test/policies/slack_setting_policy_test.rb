# frozen_string_literal: true

require 'test_helper'

class SlackSettingPolicyTest < ActiveSupport::TestCase
  describe 'user' do
    describe 'index' do
      it 'only returns projects belonging to current users organisation' do
        refute SlackSettingPolicy.new(users(:joe), slack_settings(:one)).index?
      end
    end

    describe 'show' do
      it 'allows if own organisation' do
        assert SlackSettingPolicy.new(users(:joe), slack_settings(:one)).show?
      end

      it 'rejects if not own organisation' do
        refute SlackSettingPolicy.new(users(:joe), slack_settings(:two)).show?
      end
    end

    describe 'create' do
      it 'allows if own organisation' do
        assert SlackSettingPolicy.new(users(:joe), slack_settings(:one)).create?
      end

      it 'rejects if not own organisation' do
        refute SlackSettingPolicy.new(users(:joe), slack_settings(:two)).create?
      end
    end

    describe 'edit' do
      it 'allows if own organisation' do
        assert SlackSettingPolicy.new(users(:joe), slack_settings(:one)).edit?
      end

      it 'rejects if not own organisation' do
        refute SlackSettingPolicy.new(users(:joe), slack_settings(:two)).edit?
      end
    end

    describe 'update' do
      it 'rejects outright' do
        assert SlackSettingPolicy.new(users(:joe), slack_settings(:one)).update?
      end
    end

    describe 'destroy' do
      it 'allows if own organisation' do
        assert SlackSettingPolicy.new(users(:joe), slack_settings(:one)).destroy?
      end

      it 'rejects if not own organisation' do
        refute SlackSettingPolicy.new(users(:joe), slack_settings(:two)).destroy?
      end
    end
  end
end
