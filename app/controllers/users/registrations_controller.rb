class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # GET /users/sign_up
    def new
        puts "\n\n\n\nUSER start!!!!!!!!\n\n\n\n"
        
        @auth = session['devise.twitter_data'] if session['devise.twitter_data']

        @hashed_user = {}
        @hashed_user = not_complete_user_instance_from_omniauth if @auth && %w(twitter google).include?(@auth['urls'].keys.last.downcase)
        puts @hashed_user
        puts "\n\n\n\nUSER end!!!!!!!!\n\n\n\n"
        super
    end
    
    # POST /users
    def create
        puts params[:user]
        
        puts
        puts
        email   = params[:user]['email']
        mail    = params[:user]['mail']
        puts email
        puts mail
        puts
        puts
        
        puts params[:user]
        # redirect_to :back
        super
    end
    
    # GET /users/edit
    # def edit
    #   super
    # end
    
    # PUT /users
    # def update
    #   super
    # end
    
    # DELETE /users
    # def destroy
    #   super
    # end
    
    # GET /users/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end
    
    protected
    
    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
        allow_attributes.each do |attr|
            devise_parameter_sanitizer.permit(:sign_up, keys: [attr.to_sym])
        end
    end
    
    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end
    
    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end
    
    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
    
    # ----
    ## CUSTOM methods

    def not_complete_user_instance_from_omniauth        # by YHK
        user        = flash[:user]
        need_field  = flash[:need_field]
        hashed_user = {}
    
        # attribute selector
        default_no_field = except_attributes
        need_field.each { |nf| default_no_field << nf }
        no_field = default_no_field
    
        # field collector
        user.each do |key, attr|
            next if no_field.include?(key) || attr.nil?
            hashed_user[key] = attr
        end
    
        hashed_user
    end
    
    def except_attributes
        super
    end
    
    def allow_attributes(add_except: [])
        attributes = User.attribute_names - except_attributes - add_except
        others = %w(
            encrypted_password
            reset_password_token
            reset_password_sent_at
            remember_created_at
            sign_in_count
            current_sign_in_at
            last_sign_in_at
            current_sign_in_ip
            last_sign_in_ip
        )
        attributes = attributes - others
        
        return attributes
    end
end
