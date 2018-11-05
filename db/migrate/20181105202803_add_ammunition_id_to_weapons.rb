class AddAmmunitionIdToWeapons < ActiveRecord::Migration[5.2]
  def change
    add_column :weapons, :ammunition_id, :integer
  end
end
