class ApplicationController < ActionController::Base

    # Runs every-time when user visits private end-points and check token which is sent by user to authorize him/her
    def authorize_request
        if request.headers[:authorization] 
          token_from_client = request.headers[:authorization] # refer note:1 at bottom
        else
          token_from_client = request.params[:authorization] # refer note:2 at bottom
        end
        begin
          @decoded = JsonWebToken.decode(token_from_client)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
           puts "===First==="
           puts e
           puts "======="
           render :error_page, status: :unauthorized
        rescue JWT::DecodeError => e
          puts "===Second===="
          puts e
          puts "======="
          render :error_page, status: :unauthorized
        end
    end
end
          

# Note-1: when user logged-in we check credentials and if it is right then we generate JWT token then give it as response to client(front-end developer),so client stores it somewhere
#         and then make all sub-sequent requests with sending token in request header so,we can say send token in request header is responsibilty of client(front-end developer)

# Note-2: here I am not making api so it is hard to set request header from server-side so, I have option like store token in cookies,but that was we did in cookie-based authentication,one of the limitations of cookie-based authentication is that we have to store it in database as well as in cookies and to overcome this JWT comes in picture,
#         so here I avoid storing token in cookies and instead passing it in params although it was not a good idea as it is too easy to violate the application but right now i implemented it just to know work-flow and try to find some better solution in future 
