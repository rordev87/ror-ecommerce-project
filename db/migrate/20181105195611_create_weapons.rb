class CreateWeapons < ActiveRecord::Migration[5.2]
  def change
    create_table :weapons do |t|
      t.string :name
      t.text :description
      t.decimal :weight
      t.decimal :price
      t.string :image
      t.boolean :in_stock
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
