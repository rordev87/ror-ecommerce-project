class Category < ApplicationRecord
  has_many :weapons

  validates :name, uniqueness: true
  validates :name, presence: true
end
