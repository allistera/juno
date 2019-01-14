# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :rememberable, :trackable, :validatable
  include Gravtastic
  gravtastic

  validates :name, presence: true

  validates :terms_and_conditions, acceptance: { accept: 'yes' }, allow_nil: false, on: :create
  belongs_to :organisation, optional: true

  after_create :make_admin

  def role
    return 'Platform Admin' if platform_admin
    return 'Admin' if admin

    'User'
  end

  private

  # Make this user a organisation admin unless they have been invited
  def make_admin
    update(admin: true) unless invitation_token
  end
end
