#!/bin/bash

if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
  echo "This is a pull request. No tweeting!"
  exit 0
fi

if [[ "$TRAVIS_BRANCH" != "master" ]]; then
  echo "Testing on a branch other than master. No tweeting!"
  exit 0
fi

export build_url="https://travis-ci.org/$TRAVIS_REPO_SLUG/builds/$TRAVIS_BUILD_ID"
export tweet="$1 $build_url"

echo "Prepearing to send tweet: $tweet"
./tweet.rb "$tweet"
