#sdk-starter-ruby
This is a starter app to help you start build a inbox app in gist.

This app is built using Ruby on Rails. 

##Basic Usage
This repo contains a bare-bones example that demonstrates how to create a custom app in Gist, including connecting with OAuth 
and initialize and submit endpoints. You can use this project as a base starter to quickly build custom apps with Gist.

###action paths
Repo code includes comments on how initialize and submit path is to be used in building a gist inbox app.
Also has a action path to handle the OAuth redirection and perform token exchange with Gist.
For more info on OAuth visit <a href="https://developers.getgist.com/#introduction" target="_blank">gist developer documentation</a>

```/app/controllers/app_data_controller.rb```

###gist-api-ruby gem usage
```ruby 
gem gist-api-ruby
``` 
Gem has been pre included in the repository. App shows basic usage on how to use the gem to access the REST APIs.
See <a href="https://github.com/gistplatform/gist-api-ruby" target="_blank">gem repository</a> for all available actions in gem

```/app/controllers/concerns/process_action_concern.rb```

###To get started

1. <a href="https://app.getgist.com" target="_blank">Sign up</a> for Gist
2. Create a developer app <a href="https://app.getgist.com/developer" target="_blank">here</a>
3. Grab your app credentials
4. Clone this repo
5. Set ClientId and ClientSecret to the credentials from the application you added in step 3.
6. Build and run the application
