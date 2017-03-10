class Site < ApplicationRecord
  belongs_to :project
  has_many :checks
  validates :name, :url, presence: true

  def active?
    last = checks.order('created_at desc').limit(1).first
    return false unless last && last.status
    last.status.between?(200, 299)
  end
end
