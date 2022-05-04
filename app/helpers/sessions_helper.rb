module SessionsHelper

    # return current user after authenticate it with cookie
    def current_user
        if (session_id = cookies.signed[:session_id])
            @session = Session.find_by(id: session_id)
            if @session && @session.authenticated?(cookies.signed[:remember_token])
              return @current_user = User.find_by(id: @session.user_id)
            end
        end
    end

    def loggedin?
        !current_user.nil?
    end

    def logout
        Session.destroy(cookies.signed[:session_id])
        cookies.delete(:session_id)
        cookies.delete(:remember_token)
    end

    def logoutall
        current_session = Session.find_by(id: cookies.signed[:session_id])
        all_sessions_with_current_user = Session.where(user_id: current_session.user_id)
        all_sessions_with_current_user.destroy_all
    end

    # to generate token and store it in databse as well as in cookie
    def remember(session)
        session.token
        cookies.signed[:session_id] = { value: session.id, expires: 1.minute.from_now }
        cookies.signed[:remember_token] = { value: session.remember_token, expires: 1.minute.from_now }
    end
end
