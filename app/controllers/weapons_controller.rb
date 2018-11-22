class WeaponsController < ApplicationController
  def index
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

  def add_to_cart
    flash[:notice] = ''
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    weapon = Hash["id" => id, "quantity" => quantity]
    unless session[:weapon_item].any? { |item| item['id'] == id}
      product = Weapon.find(1)
      flash[:notice] = "#{product.name} added to cart!"
      session[:weapon_item] << weapon
    end
    redirect_to weapons_path
  end

  def remove_from_cart
    # session[:weapon_item].delete(params[:id])
    session[:weapon_item] = []

    redirect_to weapons_path
  end

  private
    def weapon_params
      params.require(:search, :filter, :status).permit(:search, :filter, :status)
    end
end
