module AmznasinsHelper
	def self.new_asin(asin)
		new_asin = Amznasin.find_by(asin:asin)
		if !new_asin
			new_asin = Amznasin.create!(asin:asin)
		end
		new_asin
	end
end
