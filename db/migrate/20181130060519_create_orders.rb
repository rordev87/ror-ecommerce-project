class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.datetime :order_date
      t.datetime :delivery_date
      t.string :order_status
      t.decimal :subtotal
      t.decimal :taxes
      t.decimal :total

      t.timestamps
    end
  end
end
