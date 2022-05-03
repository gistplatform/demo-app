class AppDatum < ApplicationRecord

  ERROR_CANVAS = {}

  GIST_CLIENT_ID = "YOUR_CLIENT_ID" # provided by gist
  GIST_CLIENT_SECRET = "YOUR_CLIENT_SECRET" # provided by gist
  GIST_TOKEN_EXCHANGE_URL = "https://web-api.getgist.com/oauth/token"
  GIST_REDIRECT_URI = "https://your-domain.site/redirect" # configured in gist
end
