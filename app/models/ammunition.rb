class Ammunition < ApplicationRecord
  has_many :weapon_ammunitions, :dependent => :destroy
  has_many :weapons, through: :weapon_ammunitions

  validates :name, uniqueness: true
  validates :name, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
