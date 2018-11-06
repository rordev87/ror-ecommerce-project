ActiveAdmin.register Page do
  permit_params :title, :slug, :url, :main_content, :secondary_content, :sidebar

end
