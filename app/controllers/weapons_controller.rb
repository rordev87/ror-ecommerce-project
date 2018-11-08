class WeaponsController < ApplicationController
   def index
    @weapon_collection = Weapon.order(:name).page(params[:page])
  end

  def show
    @weapon = Weapon.find(params[:id])
  end
end
