class WeaponsController < ApplicationController
  def index
    @categories = Category.all
    @statuses = Status.all

    if params[:search].present? && params[:filter].present? && params[:status].present?
      @weapon_collection = Weapon.order(:name).page(params[:page]).where('name LIKE ? AND category_id = ? AND status_id = ?', "%#{params[:search]}%",  params[:filter], params[:status])
    elsif params[:search].present? && params[:status].present?
      @weapon_collection = Weapon.order(:name).page(params[:page]).where('name LIKE ? AND status_id = ?', "%#{params[:search]}%", params[:status])
    elsif params[:search].present? && params[:filter].present?
      @weapon_collection = Weapon.order(:name).page(params[:page]).where('name LIKE ? AND category_id = ?', "%#{params[:search]}%",  params[:filter])
    elsif params[:filter].present? && params[:status].present?
      @weapon_collection = Weapon.order(:name).page(params[:page]).where('category_id = ? AND status_id = ?', params[:filter], params[:status])
    elsif params[:search].present?
       @weapon_collection = Weapon.order(:name).page(params[:page]).where('name LIKE ?', "%#{params[:search]}%")
    elsif params[:filter].present?
      @weapon_collection = Weapon.order(:name).page(params[:page]).where("category_id = ?", params[:filter])
    elsif params[:status].present?
       @weapon_collection = Weapon.order(:name).page(params[:page]).where("status_id = ?", params[:status])
    else
      @weapon_collection = Weapon.order(:name).page(params[:page])
    end
  end

  def show
    @weapon = Weapon.find(params[:id])
  end

  private
    def weapon_params
      params.require(:search, :filter, :status).permit(:search, :filter, :status)
    end
end
