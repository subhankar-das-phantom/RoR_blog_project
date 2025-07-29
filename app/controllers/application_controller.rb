# In app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # This method gives Devise permission to accept and save the new fields.
  def configure_permitted_parameters
    # This is the FIX. We are adding :first_name and :last_name here.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
    
    # We also add them here for when users edit their profile later.
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :current_password])
  end
end
