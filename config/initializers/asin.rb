ASIN::Configuration.configure do |config|
  config.secret        = ENV['AMZN_SECRET_KEY']
  config.key           = ENV['AMZN_ACCESS_KEY']
  config.associate_tag = ENV['ASSOCIATE_TAG']
end