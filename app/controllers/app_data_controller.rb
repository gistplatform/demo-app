class AppDataController < ApplicationController
  include ProcessActionConcern

  skip_before_action :verify_authenticity_token, only: %i[initialize_path submit_path]
  before_action :set_app_data, only: %i[initialize_path submit_path]

  # :redirect_uri path for OAuth
  # user is redirected to this path after authorizing your app permissions in gist with access_grant(:code) and workspace_id(:state)
  def redirect_path
    # :state will contain the workspace id of the installing project
    # :code contains the auth code required for token exchange
    return render error_page if params[:code].blank? || params[:state].blank? # Both params are required for completing OAuth

    # Create app_data record against the workspace
    # Exchange the received auth_code with gist to get access_token
    # Save the access_token against the workspace
    @app_datum = AppDatum.find_or_create_by(workspace_id: params[:state])
    @app_datum.gist_access_token = exchange_token_with_gist(params[:code])
    @app_datum.save!

    # Acknowledge successful installation with gist. Installation will be marked complete only after acknowledge is received.
    redirect_to "https://web-testing.getgist.com/install_success?client_id=#{AppDatum::GIST_CLIENT_ID}&workspace_id=#{@app_datum.workspace_id}"
  end

  # :initialize_url path for app configuration
  # request(POST) will be sent to this path on initial conversation load.
  # request_body:
  #   conversation_id: Unique ID of the current conversation loaded
  #   inbox_app_id: Unique ID of the registered app in GIST
  #   user_id: Unique ID of the teammate
  #   user_secret: slug secret of the teammate
  #   workspace_id: slug secret of the workspace. Will be same as the workspace_id(:state) received in OAuth redirect.
  def initialize_path
    # returning a simple canvas with button to fetch contacts name of the current conversation
    components = [{"type":"list", "disabled":false, "items": [{"id":"title", "type":"item", "title":"Demo App - by Gist", "image":"https://d3iahwxie98s37.cloudfront.net/white-label/gist/logo.png", "image_width":18, "image_height":18, "rounded_image":false, "disabled":false},
                  {"id":"get_contact", "type":"item", "title":"Get contact name", "image_width":18, "image_height":18, "rounded_image":false, "disabled":false, "action":{"type":"submit"}}] }]
    render json: { "canvas" => { "content" => { "components" => components } } }, status: 200
  end

  # :submit_url path for app configuration
  # request will be sent to this path on each submit action performed inside your canvas.
  # request_body:
  #   conversation_id: Unique ID of the current conversation loaded
  #   inbox_app_id: Unique ID of the registered app in GIST
  #   user_id: Unique ID of the teammate
  #   user_secret: slug secret of the teammate
  #   workspace_id: slug secret of the workspace. Will be same as the workspace_id(:state) received in OAuth redirect.
  #   component_id: id attribute of the component clicked in the rendered canvas
  #   current_canvas: {}. Will contain the json canvas response of the rendered canvas
  #   input_values: {}. Contains the values of input field if any during the submit action.
  def submit_path
    # get the client component from params. Perform actions accordingly to render next canvas
    @action = params[:component_id]
    # Perform dynamic method call based on action performed
    # ex: This calls the method perform_get_contact_action if get_contact button is clicked from initialize canvas
    send("process_#{@action}_action")
  end

  private

  def set_app_data
    @app_datum = AppDatum.find_by(workspace_id: params[:workspace_id])
  end

  def exchange_token_with_gist(auth_code)
    # POST request to token_exchange_url to exchange the access_grant and receive access_token
    @uri = URI.parse(AppDatum::GIST_TOKEN_EXCHANGE_URL)
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.read_timeout = 60
    request = Net::HTTP::Post.new(@uri.request_uri, { "Content-Type" => "application/json" })
    request.body = {"grant_type": "authorization_code", "code": auth_code, "redirect_uri": AppDatum::GIST_REDIRECT_URI,
                    "client_id": AppDatum::GIST_CLIENT_ID, "client_secret": AppDatum::GIST_CLIENT_SECRET }.to_json
    response = http.request(request)

    json_response = JSON.parse(response.body)
    p json_response
    json_response['access_token']
  end
end
