class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :rememberable, :trackable, :validatable

  belongs_to :organisation, optional: true
end
