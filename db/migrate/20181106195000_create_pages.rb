class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :slug
      t.string :url
      t.string :title
      t.text :main_content
      t.text :secondary_content
      t.text :sidebar

      t.timestamps
    end
  end
end
