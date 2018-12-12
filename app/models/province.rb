class Province < ApplicationRecord
  validates :name, uniqueness: true
<<<<<<< HEAD
  # validates :name, :tax, presence: true
  # validates :tax, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
=======
  validates :name, :tax, presence: true
  validates :tax, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
>>>>>>> c8e0775f412cce674971b314da53e2d873e3689f

  has_many :users
end
