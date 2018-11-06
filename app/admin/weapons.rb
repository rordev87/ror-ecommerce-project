ActiveAdmin.register Weapon do
  permit_params :name, :description, :in_stock, :weight, :price, :image, :category_id

end
