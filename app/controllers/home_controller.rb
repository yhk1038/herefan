class HomeController < ApplicationController
    def index
        
        #
        ## To use for navbar
        @kind_of_notice = ['Comments', 'Mentions', 'Maeum']
        
        #
        ## To use for carousel
        @carousel = []
        
        ### first
        dummy = {}
        dummy['img_uri'] = 'https://68.media.tumblr.com/c6cfdccbeabd7eb3352cdfd44933cb95/tumblr_ojc0pmMOjH1sqfpcio1_500.gif'
        dummy['description'] = ''
        @carousel << dummy

        ### second
        dummy = {}
        dummy['img_uri'] = 'https://s-media-cache-ak0.pinimg.com/originals/69/e9/33/69e933aaada2447a07bcdc19728df596.gif'
        dummy['description'] = ''
        @carousel << dummy

        ### third
        dummy = {}
        dummy['img_uri'] = 'http://pa1.narvii.com/5736/9936ce0ff30a1d4bca813d3a96effff28ffa380a_hq.gif'
        dummy['description'] = ''
        @carousel << dummy
        
    end
end