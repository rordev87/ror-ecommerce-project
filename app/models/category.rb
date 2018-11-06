class Category < ApplicationRecord
  belongs_to :weapon

  validates :name, uniqueness: true
  validates :name, presence: true
end
