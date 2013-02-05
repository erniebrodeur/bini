source 'https://rubygems.org'

gemspec

group :development do
	gem "guard"
	gem "guard-bundler"
	gem "guard-rspec"
	gem "guard-yard"
	gem "guard-shell"
	gem "reek"
	gem "pry"
	gem 'libnotify', 	:require => false
	gem 'growl', 			:require => false
	gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'redcarpet',  :require => false
end

group :test do
	gem "rspec"
	gem "rake"
	gem 'childprocess'
	gem 'simplecov'
	gem 'bini-test-subcommand', git:"git@github.com:erniebrodeur/bini-test-subcommand.git"
	#gem 'bini-test-prefix', git:"git@github.com:erniebrodeur/bini-test-prefix.git"
end
