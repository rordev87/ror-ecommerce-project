class AddForeignKeysToWeapons < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :ammunitions, :weapons
    add_foreign_key :categories, :weapons
  end
end
