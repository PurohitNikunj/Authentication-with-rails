class UsersController < ApplicationController

    before_action :authorize_request, only: [:show, :index]

    # initialise new instance of model class
    def new
        @user = User.new
    end

    # save instance to databse
    def create
        @user = User.new(user_params)
        if @user.save
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

end
