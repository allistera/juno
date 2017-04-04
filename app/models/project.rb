class Project < ApplicationRecord
  has_many :sites, dependent: :destroy
  has_one :slack_setting, dependent: :destroy
  validates :name, presence: true
end
