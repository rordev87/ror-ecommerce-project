class Province < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :tax, presence: true
  validates :tax, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1}

  has_many :users
end
