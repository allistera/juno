class Project < ApplicationRecord
  has_many :sites
  validates :name, presence: true
end
