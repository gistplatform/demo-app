module ProcessActionConcern
  require 'gist'

  def process_get_contact_action
    # get contact button is clicked.
    # Get current conversation from gist and read contact id from conversation
    # Get contact and display full_name of contact in canvas
    conversation = gist_client.conversations.find(id: params[:conversation_id])
    contact_id = conversation['contacts'][0]['id']
    contact = gist_client.contacts.find(id: contact_id)
    components = [{"type":"list", "disabled":false, "items":
      [{"id":"title", "type":"item", "title":(contact['name'] || "Site Visitor"), "image_width":18, "image_height":18, "rounded_image":false, "disabled":false}]}]
    render json: { "canvas" => { "content" => { "components" => components } } }, status: 200
  end

  private

  def gist_client
    @gist_client ||= Gist::Client.new(access_token: "Bearer #{@app_datum.gist_access_token}")
  end
end
