class PromotionsController < ApplicationController

	def index
		require 'asin'
		client = ASIN::Client.instance
		items = client.lookup 'B00VIUCHA2'
		@item_image_url = items.first.large_image.url
		# cart = client.create_cart({:asin => '1430218150', :quantity => 1})
		# p cart.cart_items.cart_item
	end
end
