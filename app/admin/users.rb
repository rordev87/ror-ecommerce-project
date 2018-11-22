ActiveAdmin.register User do
  permit_params :first_name, :last_name, :address, :city, :postal_code, :province_id

  form do |f|
    f.semantic_errors

    f.inputs "Users" do
      f.input :first_name
      f.input :last_name
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :province
    end
    f.actions
  end

end
