class UsersController < ApplicationController
  include SessionsHelper
  include AmznasinsHelper

  def new
  	@user = User.new
    @user.cashback = 0.0
  @user.click = 0
    @admin_page = false
  end

  def show
  	@user = User.find(params[:id])
    @photofeed = Photofeed.new
    photos = @user.photofeeds
    @user_zoeshes = [] 
    photos.count == 0 ? @user_zoeshes : @user_zoeshes.push(photos.first)
    photos.each_with_index do |photo, idx|
      if idx - 1 >= 0
        if photo.asin != photos[idx-1].asin
          @user_zoeshes.push(photo)
        end
      end
    end
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
      redirect_to "/products/#{params[:photofeed][:asin]}/photofeeds", notice: "The Photofeed #{@photofeed.asin} has been uploaded."
    else
      redirect_to "/products/#{params[:photofeed][:asin]}/photofeeds", notice: "The failed."
    end
  end

  def nonuser_upload
    @photofeed = Photofeed.new(photofeed_params)
    if current_user
      user_id = current_user.id
    else
      user_id = 2
    end
    @photofeed.user = User.find(user_id)
    @photofeed.amznasin = AmznasinsHelper.new_asin(@photofeed.asin)
    if params[:photofeed][:photo].nil?
      @product = client.lookup(params[:photofeed][:asin])
      @photofeed.photo = @product.first.large_image.url
    end

    if @photofeed.save
      redirect_to "/products/#{params[:photofeed][:asin]}/photofeeds", notice: "The Photofeed #{@photofeed.asin} has been uploaded."
    else
      redirect_to "/products/#{params[:photofeed][:asin]}/photofeeds", notice: "The failed."
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
