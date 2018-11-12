class AddStatusToWeapon < ActiveRecord::Migration[5.2]
  def change
    add_reference :weapons, :status
  end
end