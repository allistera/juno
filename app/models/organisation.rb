# frozen_string_literal: true

class Organisation < ApplicationRecord
  has_many :users
  has_many :projects

  validates :name, presence: true, uniqueness: true
end
