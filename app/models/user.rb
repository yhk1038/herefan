class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise  :authentication_keys => [:uniq_key]
    devise  :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable,
            :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]
    
    def has_mail?
        self.mail.length.zero? ? true : false
    end
    
    def socials
        socials = {}
        
        oauth_providers.each do |provider|
            eval("socials['#{provider}'.to_sym] = self.oauth('#{provider}') if self.oauth('#{provider}')")
        end
        return socials
    end
    
    # private
    def oauth(arg)
        case arg
            
        when 'facebook'
            # return {:provider => self.provider, :uid => self.uid} if self.provider && self.uid
            return {provider: self.provider_fb, uid: self.uid_fb, img: self.image_fb, url: self.url_fb} if self.provider_fb && self.uid_fb
            return false
            
        when 'twitter'
            # return {:provider => self.provider, :uid => self.uid} if self.provider && self.uid
            return {provider: self.provider_tw, uid: self.uid_tw, img: self.image_tw, url: self.url_tw} if self.provider_tw && self.uid_tw
            return false
            
        when 'google'
            # return {:provider => self.provider, :uid => self.uid} if self.provider && self.uid
            return {provider: self.provider_gg, uid: self.uid_gg, img: self.image_gg, url: self.url_gg} if self.provider_gg && self.uid_gg
            return false
            
        else
            return nil
        end
    end
    
    # private
    def oauth_providers
        %w(facebook twitter google)
    end

    # public
    def self.find_for_oauth(auth, provider, current_user)
        
        # 처음 방문하여 회원가입한 적이 없고, 특정 소셜계정(페북)으로 로그인을 하려는 경우 ~> OK
        # 특정 소셜계정(페북)으로 가입했던 사용자가 방문하였으나 로그인하지 않았고, 그(페북) 계정으로 로그인을 하려는 경우
        
        # 특정 소셜계정(페북)으로 로그인이 되어있고, 다른 소셜계정(트위터)을 연동하려는 경우.
        # 특정 소셜계정(페북)으로 가입했던 사용자가 방문하였으나 로그인하지 않았고, 다른 소셜계정(트위터)으로 로그인을 하려는 경우 # => 이전에 가입한 적이 있나요?(Signed before?)
        
    
        # 만약 로그인이 되어있는 상태라면
        user = current_user if current_user
        
        # 만약 로그인이 안되어 있다면
        user = User.new unless current_user
        
        case provider
        when 'facebook'
            @user_ = User.where(provider_fb: auth.provider, uid_fb: auth.uid).first
            puts
            puts @user_.to_json
            puts
            user.fill_facebook_info(auth, user).save   unless @user_
            
        when 'twitter'
            @user_ = User.where(provider_tw: auth.provider, uid_tw: auth.uid).first
            user.fill_twitter_info(auth, user)    unless @user_
            
        when 'google'
            @user_ = User.where(provider_gg: auth.provider, uid_gg: auth.uid).first
            user.fill_google_info(auth, user).save     unless @user_
            
        end
        
        
        return user unless @user_   # 최종 반환값은 user 객체이어야 한다.
        return @user_
    end

    # public?
    def self.new_with_session(params, session)
        super.tap do |user|
            if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
                user.email = data['email'] if user.email.blank?
            end
        end
    end

    def fill_facebook_info(auth, user)
        
        user.provider_fb    = auth.provider
        user.uid_fb         = auth.uid
        
        user.name           = auth.info.name
        user.mail           = auth.info.email
        user.password       = Devise.friendly_token[0,20]
        
        user.image_fb       = auth.info.image
        user.image          = auth.info.image if user.image.nil? || user.image == '/default-user-image.png' && auth.info.image != nil
        
        user.email          = randomic_email_format
        
        return user
    end

    def fill_twitter_info(auth, user)
    
        user.provider_tw    = auth.provider
        user.uid_tw         = auth.uid

        user.name           = auth.info.name
        user.mail           = ''
        user.password       = Devise.friendly_token[0,20]

        user.image_tw       = auth.info.image
        user.image          = auth.info.image if user.image.nil? || user.image == '/default-user-image.png' && auth.info.image != nil
        
        user.url_tw         = TWITTER_DOMAIN + auth.info.nickname

        user.email          = randomic_email_format
                
        return user
    end
    
    def fill_google_info(auth, user)
    
        user.provider_gg    = auth.provider
        user.uid_gg         = auth.uid

        user.name           = auth.info.name
        user.mail           = auth.info.email
        user.password       = Devise.friendly_token[0,20]

        user.image_gg       = auth.info.image
        user.image          = auth.info.image if user.image.nil? || user.image == '/default-user-image.png' && auth.info.image != nil
    
        user.email          = randomic_email_format
        
        return user
    end
    
    def randomic(big_count: 20, count: 5)
        (('a'..'z').to_a + ('A'..'Z').to_a + (1..20).to_a.map{|i| i.to_s}).sample(big_count).sample(count).join
    end
    
    def randomic_email_format
        "#{randomic(count: 8)}@#{randomic}.#{randomic(count: 3)}"
    end
end
