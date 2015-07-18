class AmznasinsController < ApplicationController
	def show
		asin = params[:asin]
		@asin_products = Amznasin.find_by(asin:asin).photofeeds
		require 'asin'
  	client = ASIN::Client.instance
  	@product = client.lookup asin
	end
end
