require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do 

  describe "POST /users" do 

    describe "on success" do 
      
      it "creates a user from the params"

      it "returns the new user and a JWT token"
    end

    describe "on error" do

      it "required a valid email or password" 
    end
  end
end