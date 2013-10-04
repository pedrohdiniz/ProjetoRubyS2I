class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


    def index   
        if params[:code]
            # acknowledge code and get access token from FB
            session[:access_token] = session[:oauth].get_access_token(params[:code])
        end 
 
        # auth established, now do a graph call:
        @api = Koala::Facebook::API.new(session[:access_token])
	 
        begin
            @user_profile = @api.get_object("me")
        rescue Exception=>ex
            puts ex.message
            #if user is not logged in and an exception is caught, redirect to the page where logging in is requested
            redirect_to '/login' and return
        end
 
        respond_to do |format|
         format.html {   }    
        end
    end

    
    #########################################################
     
    def login
        session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/')
        @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"user_friends")  
 
        redirect_to @auth_url
    end
     
    #########################################################


    #########################################################
def delete
   session[:access_token] = nil
#   redirect_to 'http://www.google.com'
end
	#################################################

  def getfriends
    @api = Koala::Facebook::API.new(session[:access_token])

    @result = @api.get_connections("me","friends")
 
    # @result.class
    # @result.first
    # @result1 = Friend.new(name: @result.first["name"], id_friend: @result.first["id"] )
    # @result1.save


    $i = 0
    @result.each do |like|
      @post = Friend.new(name: like["name"], id_friend: like["id"] )
         puts $1
      @post.save
      $i +=1
      #break the loop in 10
      break if $i == 10
    end
      
  end
end
