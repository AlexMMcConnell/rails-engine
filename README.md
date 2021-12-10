# Rails Engine

[Rails Engine](https://backend.turing.edu/module3/projects/rails_engine/) is a Ruby on Rails application designed by [Turing School of Software and Design](turing.io). This is the backend portion, which is designed with one primary purpose in mind; creating an API to communicate with a separate frontend application.

## Versions

- Rails 5.2.6
- Ruby 2.7.2

## Setup

- Clone this repository and run the following commands:
- `$ bundle exec rails db:create`
- `$ bundle exec rails db:migrate`
- `$ bundle exec rake csv_import:destroy_data`
- `$ bundle exec rake csv_import:seed_data`
- Run this application using `rails s`

## Testing
`$ bundle exec rspec`
