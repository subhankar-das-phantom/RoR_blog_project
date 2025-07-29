class Admin::SessionsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'admin'

  def new
  end

  def create
    # Simple hardcoded admin credentials for demo
    if params[:username] == 'admin' && params[:password] == 'admin123'
      session[:admin_authenticated] = true
      redirect_to admin_root_path, notice: 'Successfully logged in as admin.'
    else
      flash.now[:alert] = 'Invalid admin credentials.'
      render :new
    end
  end

  def destroy
    session[:admin_authenticated] = nil
    redirect_to root_path, notice: 'Admin logged out successfully.'
  end
end