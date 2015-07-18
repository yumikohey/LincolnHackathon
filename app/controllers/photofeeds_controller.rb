class PhotofeedsController < ApplicationController
	include SessionsHelper
	include AmznasinsHelper

	def index
		asin_id = Amznasin.find_by(asin:params[:amznasin_asin]).id
		@all_instas = Photofeed.where(amznasin:asin_id)
		asin = params[:amznasin_asin]
		require 'asin'
  	client = ASIN::Client.instance
  	@product = client.lookup asin
	end

	def new
		@photofeed = Photofeed.new
	end

	def create
		@photofeed = Photofeed.new(photofeed_params)
		@photofeed.user_id = current_user.id
		if @photofeed.save
		  redirect_to root_path, notice: "The Photofeed #{@photofeed.asin} has been uploaded."
		else
		  render "new"
		end 
	end

	def destroy
		@photofeed = Photofeed.find(params[:id])
    @photofeed.destroy
    redirect_to "/products/#{params[:amznasin_asin]}/photofeeds", notice:  "The photofeed #{@photofeed.asin} has been deleted."
	end

	private
	  def photofeed_params
	    params.require(:photofeed).permit(:asin, :photo, :description)
	  end
end
