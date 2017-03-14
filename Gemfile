source 'https://rubygems.org'

git_source(:github) do |repo_name|
    repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
    "https://github.com/#{repo_name}.git"
end

# plugin group for coding
gem 'awesome_print'         # 콘솔에서 자료구조를 위상에 따라 전개
gem 'faker'                 # 더미 텍스트 생성
gem 'seed_dump'             # 현재 레코드를 시드 파일로 백업

# 회원인증 및 권한설정을 위한 젬
gem 'devise'                    # 회원가입 및 인증
gem 'omniauth'                  # 디바이스 소셜 계정 인증
gem 'omniauth-facebook'         # 페이스북 인증
gem 'omniauth-twitter'          # 트위터 인증
gem 'omniauth-google-oauth2'    # 구글 인증

gem 'rolify'                # role 관리
gem 'authority'             # 권한설정
gem 'cancancan'             # 더 편한 방식의 권한설정

# 개발 환경에서 가상동작이 필요한 기능을 위한 젬
gem 'letter_opener', group: :development # 개발 시, 실제로 이메일을 발송하는 대신 브라우저에서 이메일을 볼 수 있도록 해 준다.

# 페이지 뷰를 깔끔하게 보이도록 하기 위해서 아래의 두 젬을 추가로 설치한다.
# gem 'bootstrap-sass'
# gem 'simple_form'


# ==============================================================================

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'figaro'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platform: :mri
end

group :development do
    # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
    gem 'web-console', '>= 3.3.0'
    gem 'listen', '~> 3.0.5'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
