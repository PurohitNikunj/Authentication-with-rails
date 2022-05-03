class User < ApplicationRecord
    attr_accessor :remember_token
    has_secure_password
    validates :password, confirmation: true
    validates_presence_of :username, :password, :password_confirmation

    class << self  # (declare sub-sequent methods as Class-methods(here "digest" and "generate_token"))

        # Return Hash of given string
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
    
        # Return a random token
        def generate_token
            SecureRandom.urlsafe_base64
        end

    end

    # generate token then encrypt it and store encrypted value in database
    def token
        self.remember_token = User.generate_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # to authenticate user via token
    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
end
