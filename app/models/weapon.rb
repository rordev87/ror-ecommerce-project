class Weapon < ApplicationRecord
  has_many :ammunitions
  has_many :categories

  validates :name, uniqueness:true
  validates :name, :description, presence: true
  validates :in_stock, inclusion: { in: [true, false] }
  validates :weight, :price, numericality: { greater_than: 0 }
end
