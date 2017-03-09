class HomeController < ApplicationController
    def index
        @kind_of_notice = ['Comments', 'Mentions', 'Maeum']
    end
end