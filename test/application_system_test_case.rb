require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  before do
    WebMock.disable!
  end
end
