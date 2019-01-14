# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'

SimpleCov.start
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'webmock/minitest'
require 'mocha/minitest'
require 'policy_assertions'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Helper method for verifying that the specified Policy applies the expected scope
    def assert_policy_scoped(expected_scope, policy)
      assert expected_scope.count.positive?
      assert_equal expected_scope.map(&:id).sort, policy.map(&:id).sort
    end
  end
end
