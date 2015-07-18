class AmznLoginsController < ApplicationController
	def index
		require 'pay_with_amazon'

		client = PayWithAmazon::Client.new(
		  ENV['AMZN_MERCHANT_ID'],
		  ENV['AMZN_ACCESS_KEY'],
		  ENV['AMZN_SECRET_KEY'],
		  sandbox: true
		)

		# client.get_order_reference_details(
		#   amazon_order_reference_id,
		#   address_consent_token: address_consent_token
		# )

		login = PayWithAmazon::Login.new(
		  ENV['AMZN_CLIENT_ID'],
		  sandbox: true # Default: false
		)


		# Make the 'get_login_profile' api call.
		#profile = login.get_login_profile(access_token)

		# name = profile['name']
		# email = profile['email']
		# user_id = profile['user_id']

		render :layout => 'empty'
	end
end
