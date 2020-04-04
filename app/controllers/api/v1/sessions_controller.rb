class Api::V1::SessionsController < ApplicationController
  def create
    lat = params[:location][:latitude].to_f
    long = params[:location][:longitude].to_f
    results = Geocoder.search([lat, long])
    edition = (results.first.city.match? /Stockholm|Gothenburg/) ? results.first.city : 'Country Wide'
    render json: {session:
      { location:
      { latitude: lat, 
        longitude: long },
        edition: edition}},
        status: 200
      
  end
end