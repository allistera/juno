# frozen_string_literal: true

require 'test_helper'

class ProbeTest < ActiveSupport::TestCase
  test 'valid probe' do
    probe = Probe.new(name: 'London', url: 'https://london.local')
    assert probe.valid?
  end

  test 'invalid without name' do
    probe = Probe.new(url: 'https://london.local')
    refute probe.valid?, 'probe is valid without a name'
    assert_not_nil probe.errors[:name], 'no validation error for name present'
  end

  test 'invalid without url' do
    probe = Probe.new(name: 'London')
    refute probe.valid?, 'probe is valid without a url'
    assert_not_nil probe.errors[:url], 'no validation error for url present'
  end
end
