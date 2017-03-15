class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    
    TWITTER_DOMAIN = 'https://twitter.com/'
end
