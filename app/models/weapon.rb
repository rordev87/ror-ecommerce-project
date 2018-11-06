class Weapon < ApplicationRecord
  has_many :weapon_ammunitions, :dependent => :destroy
  has_many :ammunitions

  validates :name, uniqueness:true
  validates :name, :description, :in_stock, presence: true
  validates :weight, :price, numericality: { greater_than_or_equal_to: 0 }
end
