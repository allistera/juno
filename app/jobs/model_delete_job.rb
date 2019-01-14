# frozen_string_literal: true

class ModelDeleteJob < ActiveJob::Base
  def perform(model)
    model.destroy!
  end
end
