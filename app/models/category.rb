class Category < ApplicationRecord
  has_many :weapons, :dependent => :destroy

  validates :name, uniqueness: true
  validates :name, presence: true
end
