class Api::V1::CartsController < ApplicationController 
  before_action :authenticate_token!, only: [:show, :update]

  def show 

  end 

  def update 

  end

end