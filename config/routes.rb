# NOTES !!
# creator's note: For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
    
    # Devise routers
    devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }
    
    # add your routers here. (between 'devise routes' and 'root path')
    
    root 'home#index'
end
