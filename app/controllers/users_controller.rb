class UsersController < ApplicationController
  include SessionsHelper
  include AmznasinsHelper

  def new
  	@user = User.new
    @admin_page = false
  end

  def show
  	@user = User.find(params[:id])
    @photofeed = Photofeed.new
    @user_zoeshes = @user.photofeeds
    @zoeshes = @user_zoeshes.count
  end

  def upload_photofeed
    require 'asin'
    client = ASIN::Client.instance

    @photofeed = Photofeed.new(photofeed_params)
    @photofeed.user = User.find(current_user.id)
    @photofeed.amznasin = AmznasinsHelper.new_asin(@photofeed.asin)
    if params[:photofeed][:photo].nil?
      @product = client.lookup(params[:photofeed][:asin])
      @photofeed.photo = @product.first.large_image.url
    end

    if @photofeed.save
      redirect_to user_path(current_user.id), notice: "The Photofeed #{@photofeed.asin} has been uploaded."
    else
      redirect_to user_path(current_user.id), notice: "The failed."
    end

  end

  def amazon_login
    if current_user
      # request.env['omniauth.auth'] contains the Authentication Hash with all the data about a user
      @user = User.from_omniauth(request.env['omniauth.auth'], current_user)
      # session[:user_id] = @user.id
      flash[:success] = "Successfully login."
    else
      flash[:warning] = "Please try again, we failed to authenticate you"
    end
    redirect_to root_path
  end

  def create
  	@user = User.new(user_params)    # Not the final implementation!
    if @user.save
      log_in @user
    	flash[:success] = "Welcome to Zoesh"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def photofeed_params
      params.require(:photofeed).permit(:asin, :photo, :description, :user_id)
    end

end
