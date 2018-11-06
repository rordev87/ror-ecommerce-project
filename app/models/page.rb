class Page < ApplicationRecord
  validates :url, :title, :slug, :main_content, :secondary_content, :sidebar
end
