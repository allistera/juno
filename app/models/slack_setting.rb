# frozen_string_literal: true

class SlackSetting < ApplicationRecord
  belongs_to :project
  validates :webhook_url, :project_id, presence: true
end
