class SessionsController < ApplicationController
  include SessionsHelper
  
  def new
    @admin_page = false
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		log_in user
      if (params[:session][:remember_me] == '1')
        remember user
      else
        forget user
      end
  		redirect_to user
  	else
  		flash.now[:danger] = "Invalid email/password combination"
      redirect_to root_path
	  end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
