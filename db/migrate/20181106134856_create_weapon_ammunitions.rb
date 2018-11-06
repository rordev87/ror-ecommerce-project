class CreateWeaponAmmunitions < ActiveRecord::Migration[5.2]
  def change
    create_table :weapon_ammunitions do |t|
      t.references :weapon, foreign_key: true
      t.references :ammunition, foreign_key: true

      t.timestamps
    end
  end
end
