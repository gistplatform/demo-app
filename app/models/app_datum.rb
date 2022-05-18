class AppDatum < ApplicationRecord

  ERROR_CANVAS = {}

  # REPLACE THESE CONSTANTS
  GIST_CLIENT_ID = "YOUR_CLIENT_ID" # provided by gist
  GIST_CLIENT_SECRET = "YOUR_CLIENT_SECRET" # provided by gist
  GIST_REDIRECT_URI = "https://6550-136-185-3-130.ngrok.io/app/redirect" # configured in Gist

  # DO NOT EDIT BELOW CONSTANTS
  GIST_REDIRECT_URI = "https://your-domain.site/app/callback" # configured in gist
end
