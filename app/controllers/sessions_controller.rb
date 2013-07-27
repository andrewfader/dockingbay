class SessionsController < Devise::SessionsController
  before_filter :configure_permitted_parameters
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:login, :password, :remember_me)
    end
  end

end
