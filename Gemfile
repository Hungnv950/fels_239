source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt", "~> 3.1", ">= 3.1.11"
gem "bootstrap-sass", "~> 3.3", ">= 3.3.7"
gem "coffee-rails", "~> 4.2"
gem "config", "~> 1.7"
gem "faker", "1.7.3"
gem "figaro", "~> 1.1", ">= 1.1.1"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails", "~> 4.3", ">= 4.3.1"
gem "kaminari", "~> 1.1", ">= 1.1.1"
gem "paperclip", "~> 5.2", ">= 5.2.1"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.5"
gem "rails-i18n"
gem "sass-rails", "~> 5.0"
gem "sidekiq"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "whenever", require: false

group :development, :test do
  gem "sqlite3"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg", "1.0.0"
  gem "rails_12factor"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
