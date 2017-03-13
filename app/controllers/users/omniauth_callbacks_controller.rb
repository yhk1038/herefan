class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]
    
    # You should also create an action method in this controller like this:
    def twitter
    
        puts "\n\n\n\n\n\n\n\n\n"
        puts request.env["omniauth.auth"]
        puts "\n\n\n\n\n\n\n\n\n"

        user = nil
        user = current_user if current_user
        @user = User.find_for_oauth(request.env["omniauth.auth"], 'twitter', user)
    
        puts @user
        puts "\n\n\n\n\n\n\n\n\n"
    
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication       #this will throw if @user is not activated
            set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
        else
            session["devise.twitter_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end
    
    def facebook
    
        puts "\n\n\n\n\n\n\n\n\n"
        puts request.env["omniauth.auth"]
        puts "\n\n\n\n\n\n\n\n\n"

        user = nil
        user = current_user if current_user
        @user = User.find_for_oauth(request.env["omniauth.auth"], 'facebook', user)

        puts @user
        puts "\n\n\n\n\n\n\n\n\n"
        
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication       #this will throw if @user is not activated
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end
    
    # More info at:
    # https://github.com/plataformatec/devise#omniauth
    
    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end
    
    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end
    
    # protected
    
    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end
end
