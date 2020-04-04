class Api::V1::SessionsController < ApplicationController
  def create
    lat = params[:location][:latitude].to_f
    long = params[:location][:longitude].to_f
    results = Geocoder.search([lat, long])
    binding.pry
    render json: {session:
      { location:
      { latitude: lat, 
        longitude: long },
        edition: results.first.city}}
      
  end
end