build:
	gem build treqs.gemspec && sudo gem install treqs-*.gem

test:
	bundle exec rspec
