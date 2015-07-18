class LandingController < ApplicationController
  def index
  	require 'asin'
  	client = ASIN::Client.instance
  	newfeeds = []
  	@photos = Photofeed.all
  	@photos.each do |photo|
  		newfeeds.push(photo.asin)
  	end
  	@items = client.lookup newfeeds
  	# @item_page = items.first.detail_page_url
  	# @item_image_url = items.first.large_image.url
  	# @item_detail = items.first.item_attributes
  end
end