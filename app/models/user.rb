class User < ActiveRecord::Base
	attr_accessor :remember_token

	before_save { self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_senstivie: false }
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
	  SecureRandom.urlsafe_base64
	end

	def remember
	  self.remember_token = User.new_token
	  update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def self.from_omniauth(auth_hash, current_user)
		# check if the login user is in DB, if not, create a new account.
		user = User.find(current_user.id)
		user.real_name = auth_hash['info']['name']
		user.amzn_email = auth_hash['info']['email']
		user.oauth_token = auth_hash['credentials']['token']
		user.save!
		user
	end

	has_many :photofeeds

end
