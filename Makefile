install:
	bundle install

start:
	ruby main.rb

test:
	bundle exec rspec

lint:
	bundle exec rubocop
