source 'http://rubygems.org'
ruby '2.0.0'

# Absolute basics
gem 'rails', '4.0.0'

# Foundation features
gem 'clearance'             # user authentication
gem 'high_voltage'          # static pages
gem 'paperclip_heroku', git: 'https://github.com/jameswilding/paperclip_heroku.git'
gem 'bluecloth'             # Markdown => HTML conversion
gem 'acts-as-taggable-on'   # Tagging

gem 'protected_attributes'
gem 'will_paginate', '>= 3.0'
gem 'tire'
#gem 'sunspot_rails'
#gem 'sunspot_solr'
gem 'fakeweb'
gem 'rails_12factor'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'carmen-rails'
gem 'rails_admin', :git => 'https://github.com/sferik/rails_admin'
gem 'haml'
gem "social-buttons", '~> 0.3'
gem "nested_has_many_through"
gem "ruby-continent"
gem "activerecord-session_store"
gem 'ransack'
#gem 'progress_bar'
#gem "monologue"
#gem "tinymce-rails"
gem 'acts-as-messageable'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

#gem 'jquery-rails', '2.3.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pg'


# Development and testing
group :development do
  gem 'spork'               # Faster testing
  gem 'database_cleaner'    # Tidy database after testing
  #gem 'autospec', git: 'git@github.com:jameswilding/autospec.git'
end

group :test do
  gem 'factory_girl_rails'    # Mocking
  gem 'shoulda'             # Simpler specs
  gem 'rspec-rails'         # For specs
end

