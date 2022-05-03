module SessionsHelper

    # return current user after authenticate it with cookie
    def current_user
        if (user_id = cookies.signed[:user_id])
            @user = User.find_by(id: user_id)
            if @user && @user.authenticated?(cookies.signed[:remember_token])
              return @user 
            end
        end
    end

    def loggedin?
        !current_user.nil?
    end

    def logout
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # to generate token and store it in cookie
    def remember(user)
        user.token
        cookies.signed[:user_id] = user.id
        cookies.signed[:remember_token] = user.remember_token
    end
end
