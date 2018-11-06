class Ammunition < ApplicationRecord
  belongs_to :weapon

  validates :name, uniqueness: true
  validates :name, :description, presence: true
  validates :price, numericality { greater_than_or_equal_to: 0 }
end
