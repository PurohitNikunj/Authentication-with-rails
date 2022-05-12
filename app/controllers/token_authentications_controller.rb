class TokenAuthenticationsController < ApplicationController
    require './jwt_auth.rb'

    # render Log-in Form
    def login
    end

    # check user-credentials and generate JWT token 
    def post_login
        @user = User.find_by(username: params[:username])
        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          puts "======"
          puts token
          puts "======"
          redirect_to show_path(authorization: token)
        else
          render :error_page, status: :unauthorized
        end
    end
end
