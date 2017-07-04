require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'creates new user account' do
    assert_difference('User.count') do
      assert_difference('Organisation.count') do
        silenced do
          Rake::Task['user:create'].invoke('aabcd@gmail.com', '12341212', 'FooBar')
        end
      end
    end
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
