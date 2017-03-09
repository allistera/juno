class Site < ApplicationRecord
  belongs_to :project
  has_many :checks
  validates :name, :url, presence: true

  def active?
    return false unless checks.last
    checks.order('created_at').limit(1).first.status.between?(200, 299)
  end
end
