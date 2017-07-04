class Project < ApplicationRecord
  belongs_to :organisation
  validates :organisation, presence: true

  has_many :sites, dependent: :destroy
  has_one :slack_setting, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
