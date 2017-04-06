require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do 

  describe "POST /auth" do 

    describe "on success" do 

      before(:each) do  
        params = { 
          user: { 
            email: 'luke@flatironschool.com', 
            password: 'password' 
          } 
        }

        post "/api/v1/auth", 
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }
          
        @response = response
      end

      it "returns the existing user (from params) and a JWT token" do  
        body = JSON.parse(@response.body)

        expect(@response.status).to eq(200)
        expect(body['user']['id']).not_to eq(nil)
        expect(body['user']['email']).to eq('luke@flatironschool.com')
        expect(body['user']['password_digest']).to eq(nil)
        expect(body['token']).not_to eq(nil)  
      end
    end

    describe "on error" do

      before(:each) do  
        User.create(
          email: 'luke@flatironschool.com', 
          password: 'password'
        )
      end

      it "unable to find user with email" do  
        params = { 
          user: { 
            email: 'luke@the_pub.com', 
            password: 'password' 
          } 
        }

        post "/api/v1/auth", 
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }
          
        body = JSON.parse(response.body)

        expect(response.status).to eq(403)
        expect(body["errors"]).to eq({
          "email"=>["Unable to find a user with the provided email address"]
        })
      end

      it "password does not match the provided email" do  
        params = { 
          user: { 
            email: 'luke@flatironschool.com', 
            password: 'monkeys' 
          } 
        }

        post "/api/v1/auth", 
          params: params.to_json,
          headers: { 'Content-Type': 'application/json' }
          
        body = JSON.parse(response.body)

        expect(response.status).to eq(403)
        expect(body["errors"]).to eq({
          "password"=>["Password does not match the provided email"]
        })
      end
    end
  end
end