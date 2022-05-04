class Session < ApplicationRecord
    attr_accessor :remember_token
    belongs_to :user

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
        self.remember_token = Session.generate_token
        update_attribute(:remember_digest, Session.digest(remember_token))
    end

    # to authenticate user via token
    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
        # binding.pry
    end
end
