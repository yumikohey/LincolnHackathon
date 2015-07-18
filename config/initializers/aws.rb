AWS.config(access_key_id:     ENV['AMZN_ACCESS_KEY'],
           secret_access_key: ENV['AMZN_SECRET_KEY'] )

S3_BUCKET = AWS::S3.new.buckets[ENV['S3_BUCKET_NAME']]