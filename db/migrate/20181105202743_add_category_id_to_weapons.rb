class AddCategoryIdToWeapons < ActiveRecord::Migration[5.2]
  def change
    add_column :weapons, :category_id, :integer
  end
end
