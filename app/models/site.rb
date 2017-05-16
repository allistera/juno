class Site < ApplicationRecord
  belongs_to :project
  has_many :checks, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :project,
                                                 message: 'name must be unique' }
  validates :url, url: true
  validates :custom_status, numericality: { only_integer: true,
                                            greater_than_or_equal_to: 100,
                                            less_than_or_equal_to: 527 }, allow_nil: true

  def active?
    success?
  end

  def state
    last = checks.order('created_at desc').limit(1).first
    return :unknown unless last
    return :active if success?
    return :inactive unless success?
  end

  def uptime
    # Number of checks recieved
    total = checks.count

    # Number of inactive checks
    inactive = inactive_checks.count

    if total.zero?
      nil
    elsif inactive.zero?
      100
    else
      (100 - (inactive.to_f / total.to_f) * 100).round(2)
    end
  end

  def last_downtime
    inactive_checks.last.try(:created_at)
  end

  def inactive_checks
    if custom_status
      checks.where.not(status: custom_status)
    else
      checks.where('status < 199 OR status > 300 OR status == null')
    end
  end

  def success?
    last = checks.order('created_at desc').limit(1).first
    return false unless last && last.status

    if custom_status
      last.status == custom_status
    else
      last.status.between?(200, 299)
    end
  end
end
