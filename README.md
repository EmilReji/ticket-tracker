# README

## Intro

This is a ticket tracker app created in rails. The app operates in a similar manner to Github's issues functionality. The db is setup using postgres.

## Demo

Click [here](https://limitless-wildwood-09421.herokuapp.com/) to find the heroku demo app.

## Setup

Note if any of the command below fails, try preceding them with `bundle exec`.

Run `bundle install` to install the required Gemfiles. Make sure your either using Ruby version 2.7.1. If not, update the Gemfile so the Ruby version matches your own.

Then run `rake db:migrate` to run the migrations and ensure the database schema is setup.

Then run `rake db:seed` to load the db/seeds.rb data into the database.

Finally, run `rails server` to start the app.

## Tests

A few rspec tests have been created in the spec directory. Run them like so: `rspec`.
