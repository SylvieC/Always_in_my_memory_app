class User < ActiveRecord::Base

	before_save { |user| user.email = email.downcase }
  	before_save :create_remember_token

  has_one :view
  has_many :stacks

  has_secure_password
  private

    def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
    end 

end

