class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.string :name
      t.decimal :discount

      t.timestamps
    end
  end
end
