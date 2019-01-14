# frozen_string_literal: true

require 'test_helper'
require 'capybara/poltergeist'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers
  driven_by :poltergeist, screen_size: [1400, 1400]
  before do
    WebMock.disable!
  end
end
