class UsersController < ApplicationController

    before_action :is_authenticate, only: [:show, :index]
    before_action :current_user, only: [:show, :index]
    before_action :refresh_expiry, only: [:show, :index]

    # initialise new instance of model class
    def new
        @user = User.new
    end

    # save instance to databse
    def create
        @user = User.new(user_params)
        if @user.save
            session = @user.sessions.new()
            remember(session)
            redirect_to show_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
    end

    def index
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

    def is_authenticate
        unless loggedin?
            redirect_to login_path
        end
    end

    def refresh_expiry
        if cookies.signed[:session_id]
            cs = cookies.signed[:session_id]
            cr = cookies.signed[:remember_token]
            cookies.signed[:session_id] = { value: cs, expires: 1.minute.from_now }
            cookies.signed[:remember_token] = { value: cr, expires: 1.minute.from_now }
        else
            logout
        end
    end
end
