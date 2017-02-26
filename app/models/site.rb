class Site < ApplicationRecord
  belongs_to :project
  validates :name, :url, presence: true
end
