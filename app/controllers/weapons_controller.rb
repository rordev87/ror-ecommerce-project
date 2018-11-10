class WeaponsController < ApplicationController
  def index
    @categories = Category.all

    if params[:search] && params[:filter]
      @weapon_collection = Weapon.order(:name).page(params[:page]).where('name LIKE ?', "%#{params[:search]}%").where("category_id = ?", params[:filter][:category_id])
    elsif params[:search]
       @weapon_collection = Weapon.order(:name).page(params[:page]).where('name LIKE ?', "%#{params[:search]}%")
    elsif params[:filter]
      @weapon_collection = Weapon.order(:name).page(params[:page]).where("category_id = ?", params[:filter][:category_id])
    else
      @weapon_collection = Weapon.order(:name).page(params[:page])
    end
  end

  def show
    @weapon = Weapon.find(params[:id])
  end

  private
    def weapon_params
      params.require(:search, :filter).permit(:search, :filter)
    end
end
