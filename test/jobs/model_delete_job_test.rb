require 'test_helper'

class ModelDeleteJobTest < ActiveJob::TestCase
  describe '#perform' do
    it 'deletes object' do
      assert_difference('Site.count', -1) do
        ModelDeleteJob.perform_now(sites(:two))
      end
    end
  end
end
