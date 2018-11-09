class PagesController < ApplicationController
  def about
    @page = Page.find_by(title: 'about')
  end

  def contact
    @page = Page.find_by(title: 'contact')
  end
end
