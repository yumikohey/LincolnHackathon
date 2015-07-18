class AmznasinsController < ApplicationController
	include SessionsHelper

	def show
		asin = params[:asin]
		@asin_products = Amznasin.find_by(asin:asin).photofeeds.first
		require 'asin'
  	client = ASIN::Client.instance
  	@product = client.lookup asin
	end

	def instagram
	  require "sinatra"
	  require "instagram"

	  Instagram.configure do |config|
	    config.client_id = ENV['INSTA_CLIENT_ID']
	    config.client_secret = ENV['INSTA_CLIENT_SECRET']
	  end
	  client = Instagram.client(:access_token => ENV['INSTA_ACCESS_TOKEN'])

	  tags = Instagram.tag_search(params["/test"]["tags"])
	  tags[0].name  
	  tags[0].media_count
	  for media_item in client.tag_recent_media(tags[0].name).first(5)
	     asin = Photofeed.new(asin:params["/test"]["asin"])
	     asin.description = "instagram"
	     asin.photo = media_item.images.thumbnail.url
	     asin.user = User.find(current_user.id)
	     asin.amznasin = Amznasin.find_by(asin:params["/test"]["asin"])
	     asin.save
	  end

	  redirect_to root_path
	end

end
