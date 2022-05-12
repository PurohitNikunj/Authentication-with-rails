# In our project whenever we have to encode(generate) token or decode token we use this class's encode and decode methods instead of directly use JWT class's encode and decode method;
# this is just the concept of encapsulation;so basically we use this class's encode and decode methods and this class's methods use JWT's encode and decode method

class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

    # Generate JWT token using JWT class which is provided by jwt gem
    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end
    
    # Decode token sent by user and returns decoded payload in which the information about current-user is stored
    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded
    end
end
