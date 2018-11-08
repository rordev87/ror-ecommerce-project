class WeaponsController < ApplicationController
   def index
    @weapon_collection = Weapon.order(:name).limit(12)
  end

  def show
    @weapon = Weapon.find(params[:id])
  end
end
