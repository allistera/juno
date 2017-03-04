class Site < ApplicationRecord
  belongs_to :project
  has_many :checks
  validates :name, :url, presence: true
end
