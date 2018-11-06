class Weapon < ApplicationRecord
  has_many :ammunitions
  has_many :categories

  validates :name, uniqueness:true
  validates :name, :description, :in_stock, presence: true
  validates :weight, :price, numericality: { greater_than_or_equal_to: 0 }
end
