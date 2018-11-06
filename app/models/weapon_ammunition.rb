class WeaponAmmunition < ApplicationRecord
  belongs_to :weapon
  belongs_to :ammunition
end
