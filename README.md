## README

This is a hackathon app to play with Ruby 2.3, Rails 4, Heroku, New Relic, and User mapping patterns.

### Development Environment
Ruby and Bundler must be installed. `.env.sample` must be copied to `.env` and your app's env vars should be set.

### Heroku Production Environment
You will need a Heroku account, the heroku toolbelt installed, and to refer to [Heroku documentation](https://devcenter.heroku.com/articles/getting-started-with-rails5) to deploy the app to your own account.
Refer to
Env vars need to be set in Heroku. Example command: `$ heroku config:set NEW_RELIC_KEY=abc123`.

Setup Agile Central credentials [here](https://rally1.rallydev.com/login/accounts/index.html#/clients)
[Twitter app setup](https://apps.twitter.com/)
[Trello app setup](https://trello.com/app-key)
Example of a CAAC Callback Url:
https://test1234.ngrok.io/users/auth/agile_central/callback
https://intense-tundra-1234.herokuapp.com/users/auth/agile_central/callback

Dev notes:
Deleting sessions in Rails: `rake db:sessions:clear`

<!-- * Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ... -->
