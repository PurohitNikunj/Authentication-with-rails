class UsersController < ApplicationController

    before_action :is_authenticate, only: [:show, :index]
    before_action :current_user, only: [:show, :index]

    # initialise new instance of model class
    def new
        @user = User.new
    end

    # save instance to databse
    def create
        @user = User.new(user_params)
        if @user.save
            remember(@user)
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
end
