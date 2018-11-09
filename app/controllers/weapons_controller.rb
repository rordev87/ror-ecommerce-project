class WeaponsController < ApplicationController
  def index
    @weapon_collection = Weapon.order(:name).select(params[:category]).page(params[:page])
    # @weapon_collection = w@eapon_collection.starts_with(params[:starts_with]) if params[:starts_with].present?
  end

  def show
    @weapon = Weapon.find(params[:id])
  end
end
