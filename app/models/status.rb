class Status < ApplicationRecord
  validates :name, :discount, presence: true

  has_many :weapons
end
