class SessionsController < ApplicationController
    auto_session_timeout_actions
    
    # initialise new session
    def new
    end

    # create new session for user if credentials are right
    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session = user.sessions.new()
            remember(session)
            redirect_to show_path
        else
            flash[:error] = "Invalid Username OR password!!"
            render :new, status: :unprocessable_entity
        end
    end

    # logout from current device
    def destroy
        logout
        redirect_to login_path, status: :see_other
    end

    # logout from all devices
    def destroyall
        logoutall
        redirect_to login_path, status: :see_other
    end

end
