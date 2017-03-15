class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]
    
    # You should also create an action method in this controller like this:
    def twitter
        need_field = %w(mail)
        puts request.env['omniauth.auth']
        
        user = nil
        user = current_user if current_user
        @user = User.find_for_oauth(request.env["omniauth.auth"], 'twitter', user)
        
        if @user.has_mail?
            session["devise.twitter_data"] = request.env["omniauth.auth"].info
            redirect_to new_user_registration_path, flash: { user: @user, need_field: need_field }
        else
            if @user.persisted?
                sign_in_and_redirect @user, :event => :authentication       #this will throw if @user is not activated
                set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
            else
                session["devise.twitter_data"] = request.env["omniauth.auth"].info
                redirect_to new_user_registration_path, flash: { user: @user, need_field: need_field }
            end
        end
        
        
    end
    
    def facebook
        puts request.env["omniauth.auth"]
        
        user = nil
        user = current_user if current_user
        @user = User.find_for_oauth(request.env["omniauth.auth"], 'facebook', user)

        puts @user
        puts "\n==> end \n\n\n\n\n\n\n\n"
        
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication       #this will throw if @user is not activated
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url, flash: { user: @user, need_field: []}
        end
    end

    def google_oauth2
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        puts request.env["omniauth.auth"]
    
        user = nil
        user = current_user if current_user
        @user = User.find_for_oauth(request.env["omniauth.auth"], 'google', user)
    
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
            # flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        else
            session["devise.google_data"] = request.env["omniauth.auth"].info #.except(:extra) #Removing extra as it can overflow some session stores
            redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
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
