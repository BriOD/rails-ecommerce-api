require 'rails_helper' 

RSpec.describe "Api::V1::Carts", type: :request do  

  before(:each) do 
    @cart = create(:cart) 
    @user = @cart.user
    @token = Auth.create_token(@user.id) 
    @token_headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': "Bearer: #{@token}"
    }
    @tokenless_headers = {
      'Content-Type': 'application/json'
    }
  end

  it "it requires all routes to have a token" do   
    responses = []
    response_bodies = []

    put "/api/v1/carts/#{@cart.id}", params: { item_id: 1 }.to_json, headers: @tokenless_headers
    responses << response
    response_bodies << JSON.parse(response.body)

    get "/api/v1/carts/#{@cart.id}", headers: @tokenless_headers
    responses << response 
    response_bodies << JSON.parse(response.body)

    responses.each { |r| expect(r).to have_http_status(403) }
    response_bodies.each { |body| expect(body["errors"]).to eq([{ "message" => "You must include a JWT token!" }]) }

  end
end