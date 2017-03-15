class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def except_attributes
        %w(id created_at updated_at)
    end
end
