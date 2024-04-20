install:
	bundle install --path vendor/bundle

lint:
	bundle exec rubocop

test:
	bundle exec rake test

.PHONY: test