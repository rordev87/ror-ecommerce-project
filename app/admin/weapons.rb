ActiveAdmin.register Weapon do
  remove_filter :weapon_ammunitions, :in_stock, :image
  permit_params :name, :description, :in_stock, :weight, :price, :image, :category_id, weapon_ammunitions_attributes: [:id, :weapon_id, :ammunition_id, :_destroy]


  scope :all, :default => true
  scope :available do |products|
    products.where(:in_stock => true)
  end
  scope :sold_out do |products|
    products.where(:in_stock => false)
  end

  index do
    selectable_column
    column :name
    column "Image" do |weapon|
      image_tag(weapon.image.thumb.url) if weapon.image?
    end
    column :price
    column :weight
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
        weapon.ammunitions.map { |w| link_to w.name, admin_ammunition_path(w) }.join(", ").html_safe
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
