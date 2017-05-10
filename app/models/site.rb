class Site < ApplicationRecord
  belongs_to :project
  has_many :checks, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :project,
                                                 message: 'name must be unique' }
  validates :url, url: true

  def active?
    last = checks.order('created_at desc').limit(1).first
    return false unless last && last.status
    last.status.between?(200, 299)
  end

  def state
    last = checks.order('created_at desc').limit(1).first
    return :unknown unless last
    return :active if last.status.between?(200, 299)
    return :inactive if last.status < 200 || last.status > 299
  end

  def uptime
    # Number of checks recieved
    total = checks.count

    # Number of inactive checks
    inactive = checks.where('status < 199 OR status > 300').count

    if total.zero?
      nil
    elsif inactive.zero?
      100
    else
      (100 - (inactive.to_f / total.to_f) * 100).round(2)
    end
  end

  def last_downtime
    checks.where('status < 199 OR status > 300').last.try(:created_at)
  end
end
