class Ammunition < ApplicationRecord
  belongs_to :weapon

  validates :name, uniqueness: true
  validates :name, :description, presence: true
  validates :price, numericality { greater_than: 0 }
end
