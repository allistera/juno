require 'test_helper'

class SlackSettingTest < ActiveSupport::TestCase
  test 'valid slack setting' do
    setting = SlackSetting.new(webhook_url: 'http://foo.bar', project: projects(:one))
    assert setting.valid?
  end

  test 'invalid without webhook url' do
    setting = SlackSetting.new(project: projects(:one))
    refute setting.valid?
    assert_not_nil setting.errors[:webhook_url]
  end
end
