# sdk-starter-ruby

## Basic Usage
This repo contains a bare-bones example that demonstrates how to create a custom app in Gist, including connecting with OAuth 
and handling initialize and submit endpoints. You can use this project as a base starter to quickly build custom apps with Gist.

**Note**: This app uses [gist-api-ruby](https://github.com/gistplatform/gist-api-ruby) to interact with the [Gist REST API](https://developers.getgist.com/api)

### What you need
- [A Gist developer account](https://app.getgist.com/)
- [A Gist inbox app](https://developers.getgist.com/docs)
### Instructions

To install this starter app on your local environment, clone the repository and install dependencies.

```shell
git clone https://github.com/gistplatform/sdk-starter-ruby.git
cd sdk-starter-ruby
bundle install
```

Replace the `GIST_CLIENT_ID`, `GIST_CLIENT_SECRET` and `GIST_REDIRECT_URI` values in `/app/models/app_datum.rb` appropriately after enabling OAuth in your app detail page in your [Developer Hub](https://app.getgist.com/developer).

Start the server. 
```shell
rails s
```
To test this app, we recommend using [ngrok](https://ngrok.io) service to make your localhost accessible publicly and configure the `initialize`, `submit` and `redirect_uri` endpoints in your Gist app.

Now that the app is setup, you can change what the app does by updating the code under the `initialize_path` and `submit_path` methods in `/app/controllers/app_data_controller.rb`

For more details, visit our <a href="https://developers.getgist.com/docs" target="_blank">developer documentation</a>
