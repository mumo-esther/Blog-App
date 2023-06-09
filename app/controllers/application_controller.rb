class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  # Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  include CanCan::ControllerAdditions # or CanCanCan::ControllerAdditions

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio email password current_password])
  end
end
