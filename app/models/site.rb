class Site < ApplicationRecord
  include AASM

  belongs_to :project
  has_many :checks, dependent: :destroy
  after_commit :broadcast_change
  validates :name, presence: true, uniqueness: { scope: :project,
                                                 message: 'name must be unique' }

  validates :url, url: true
  validates :custom_status, numericality: { only_integer: true,
                                            greater_than_or_equal_to: 100,
                                            less_than_or_equal_to: 527 }, allow_nil: true

  aasm column: 'status' do
    state :unknown, initial: true
    state :active
    state :inactive

    event :success do
      transitions from: :unknown, to: :active
      transitions from: :active, to: :active
      transitions from: :inactive, to: :active, after: proc { |*_args| slack_notification }
    end

    event :fail do
      transitions from: :inactive, to: :inactive
      transitions from: :unknown, to: :inactive
      transitions from: :active, to: :inactive, after: proc { |*_args| slack_notification }
    end
  end

  def broadcast_change
    ActionCable.server.broadcast 'status',
                                 site: id,
                                 name: name,
                                 url: url,
                                 status: status
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
      checks.where('status < 199 OR status > 300')
    end
  end

  def slack_notification
    SlackNotificationJob.perform_later(self, checks.last.status)
  end
end
