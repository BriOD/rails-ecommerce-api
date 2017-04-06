require 'rails_helper'

RSpec.describe "Api::Users", type: :request do 

  describe "POST /users" do 

    describe "on success" do 
      
      it "creates a user from the params" do
        params = { 
          user: { 
            email: 'luke@flatironschool.com', 
            password: 'password' 
          } 
        }

        post "/api/v1/users", 
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }

        body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['email']).to eq('luke@flatironschool.com')
        expect(body['user']['password_digest']).to eq(nil)
        expect(body['token']).not_to eq(nil)
      end

      it "returns the new user and a JWT token"
    end

    describe "on error" do

      it "required a valid email or password" 
    end
  end
end