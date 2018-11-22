class User < ApplicationRecord

  validates :first_name, :last_name, :province_id, :address, :postal_code, :city, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province
end
