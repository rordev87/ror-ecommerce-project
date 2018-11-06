class WeaponController < ApplicationController
  def show
    @weapon_collection = Weapon.order(:name)
  end

  def index
    @weapon = Weapon.find(params[:id])
  end
end
