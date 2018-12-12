class ApplicationController < ActionController::Base
  before_action :initialize_session
<<<<<<< HEAD
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :load_weapon_items

  private
    def initialize_session
      session[:weapon_item] ||= []
    end
=======
  # before_action :load_weapon_items

  private
  def initialize_session
    session[:weapon_item] ||= []
  end
>>>>>>> c8e0775f412cce674971b314da53e2d873e3689f

  # def load_weapon_items
  #   # @cart = Weapon.find(session[:weapon_item])
  # end
<<<<<<< HEAD

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :province_id, :address, :postal_code, :city,])
    end
=======
>>>>>>> c8e0775f412cce674971b314da53e2d873e3689f
end
