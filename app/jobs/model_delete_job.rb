class ModelDeleteJob < ActiveJob::Base
  def perform(model)
    model.destroy!
  end
end
