# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'creates new admin account' do
    assert_difference(['User.count', 'Organisation.count']) do
      silenced do
        Rake::Task['user:create_admin'].invoke('Johnny', 'aabcd@gmail.com', '12341212', 'Odin')
      end
    end
    assert User.find_by_email('aabcd@gmail.com').admin
    assert_equal 'Odin', User.find_by_email('aabcd@gmail.com').organisation.name
  end

  private

  # So we don't get puts to test output
  def silenced
    $stdout = StringIO.new

    yield
  ensure
    $stdout = STDOUT
  end
end
