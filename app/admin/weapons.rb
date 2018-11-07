ActiveAdmin.register Weapon do
  permit_params :name, :description, :in_stock, :weight, :price, :image, :category_id, weapon_ammunitions_attributes: [:id, :weapon_id, :ammunition_id, :_destroy]

  index do
    selectable_column
    column :id
    column :name
    column "Thumbnail" do |weapon|
      image_tag(weapon.image.thumb.url) if weapon.image?
    end
    column :price
    column :in_stock
    column :ammunitions do |weapon|
      weapon.ammunitions.map { |w| link_to w.name, admin_ammunition_path(w) }.join(", ").html_safe
    end
    actions
  end

  show do |weapon|
    attributes_table do
      row :name
      row :description
      row :image
      row :weight
      row :price
      row :category
      row :ammunitions do |weapon|
        weapon.ammunitions.map { |w| w.name }.join(", ").html_safe
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs "Weapon" do
      f.input :name
      f.input :description
      f.input :image
      f.input :weight
      f.input :price
      f.input :category
      f.has_many :weapon_ammunitions, allow_destroy: true do |n_f|
        n_f.input :ammunition
      end
    end
    f.actions
  end
end
