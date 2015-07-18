class Amznasin < ActiveRecord::Base
	has_many :photofeeds, dependent: :destroy
end
