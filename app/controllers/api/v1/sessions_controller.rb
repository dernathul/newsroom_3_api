class Api::V1::SessionsController < ApplicationController
  def create
    render json: {session:
      { location:
      { latitude: params[:location][:latitude].to_f, 
        longitude: params[:location][:longitude].to_f}, 
        edition: 'Gothenburg'} }
       
  end
end
