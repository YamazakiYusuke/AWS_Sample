# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

### Ruby version

### System dependencies

### Configuration

### Database creation

### Database initialization

### How to run the test suite

### Services (job queues, cache servers, search engines, etc.)

### Deployment instructions

 `$ git remote -v`
 
`$ git remote set-url heroku https://limitless-sea-53558.herokuapp.com/.git`


`$ rails assets:precompile RAILS_ENV=production`


`$ heroku buildpacks:set heroku/ruby`


`$ heroku buildpacks:add --index 1 heroku/nodejs`


`$ git push heroku master`


`$ heroku run rails db:migrate`


`$ heroku open`

* ...
