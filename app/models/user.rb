class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :rememberable, :trackable, :validatable

  belongs_to :organisation, optional: true

  after_create :make_admin

  private

  # Make this user a organisation admin unless they have been invited
  def make_admin
    update(admin: true) unless invitation_token
  end
end
