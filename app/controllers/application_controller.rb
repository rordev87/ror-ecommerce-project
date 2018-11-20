class ApplicationController < ActionController::Base
  before_action :initialize_session
  # before_action :load_weapon_items

  private
  def initialize_session
    session[:weapon_item] ||= []
  end

  # def load_weapon_items
  #   # @cart = Weapon.find(session[:weapon_item])
  # end
end
