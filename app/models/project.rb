class Project < ApplicationRecord
  has_many :sites
  has_one :slack_setting
  validates :name, presence: true
end
