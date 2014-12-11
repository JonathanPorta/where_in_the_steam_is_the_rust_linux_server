#!/usr/bin/env ruby

require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_SECRET']
end

status_message = ARGV[0]
is_pull_request = ENV['TRAVIS_PULL_REQUEST']
build_url = "https://travis-ci.org/#{ TRAVIS_REPO_SLUG }/builds/#{ TRAVIS_BUILD_ID }"

# Don't send empty tweets, or tweets for PRs.
client.update("#{ status_message } #{ build_url }") if status_message && !is_pull_request
