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
    weapon = Weapon.find(id)
    quantity = params[:quantity].to_i
    price = (weapon.price).to_i * (1 - weapon.status.discount)
    product = Hash["id" => id, "name" => weapon.name, "quantity" => quantity, "price" => price]
    unless session[:weapon_item].any? { |item| item['id'] == id}
      flash[:notice] = "#{weapon.name} added to cart!"
      session[:weapon_item] << product
    end
    redirect_to weapons_path
  end

  def increase_cart_item_quantity
    id = params[:id].to_i
    weapon = Weapon.find(id)
    item = session[:weapon_item].select { |item| item['id'] == id }
    item_index = session[:weapon_item].index(item[0])
    new_quantity = item[0]["quantity"] + 1
    session[:weapon_item][item_index]["quantity"] = new_quantity
    flash[:update] = "#{weapon.name} quantity increased to #{new_quantity}!"

    redirect_to cart_path
  end

  def decrease_cart_item_quantity
    id = params[:id].to_i
    weapon = Weapon.find(id)
    item = session[:weapon_item].select { |item| item['id'] == id }
    item_index = session[:weapon_item].index(item[0])
    new_quantity = item[0]["quantity"] - 1
    if new_quantity < 1
      session[:weapon_item].delete_at(item_index)
      flash[:update] = "#{weapon.name} quantity decreased to #{new_quantity} so it was removed!"
    else
     session[:weapon_item][item_index]["quantity"] = new_quantity
      flash[:update] = "#{weapon.name} quantity decreased to #{new_quantity}!"
    end
    redirect_to cart_path
  end

  def remove_item_from_cart
    id = params[:id].to_i
    weapon = Weapon.find(id)
    flash[:remove] = "#{weapon.name} removed from cart!"
    session[:weapon_item].delete_if { |item| item['id'] == id}

    redirect_to cart_path
  end

  def remove_all_from_cart
    # session[:weapon_item].delete(params[:id])
    session[:weapon_item] = []

    redirect_to weapons_path
  end

  def place_order
    subtotal = 0
    tax_rate = current_user.province.hst + current_user.province.gst + current_user.province.pst
    session[:weapon_item].each do |w|
      subtotal = subtotal + (w["price"].to_f * w["quantity"].to_i)
    end

    taxes = subtotal * (tax_rate)
    total = subtotal + taxes

    order = Order.create(user_id: current_user.id, order_status: "pending", subtotal: subtotal, taxes: taxes, total: total)

    session[:weapon_item].each do |w|
      order_item = OrderItem.create(weapon_id: w['id'].to_i, order_id: order.id, quantity: w['quantity'].to_i)
    end

    session[:weapon_item] = []
    redirect_to root_path
  end

  private
    def weapon_params
      params.require(:search, :filter, :status).permit(:search, :filter, :status)
    end
end
