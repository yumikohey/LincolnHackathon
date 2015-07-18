Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
  provider :amazon, ENV['AMZN_CLIENT_ID'], ENV['AMZN_CLIENT_SECRET']
end