class CleanupJob < ActiveJob::Base
  def perform
    Check.where('created_at < :weeks', weeks: 2.weeks.ago).destroy_all
  end
end
