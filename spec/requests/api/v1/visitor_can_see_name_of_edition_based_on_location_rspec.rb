RSpec.describe Api::V1::SessionsController, type: :request do
  describe ' POST /api/v1/sessions successfully' do

    it 'returns a session object with location and edition name' do
      post '/api/v1/sessions', params: {location: { latitude: 57.72, longitude: 11.93 }}
      expect(response_json['session']['edition']).to eq 'Gothenburg'
    end

    it 'returns a session object with location and edition name' do
      post '/api/v1/sessions', params: {location: { latitude: 59.32, longitude: 18.06 }}
      expect(response_json['session']['edition']).to eq 'Stockholm'
    end

    it 'returns a session object with location and edition name' do
      post '/api/v1/sessions', params: {location: { latitude: 60.02, longitude: 13.67 }}
      expect(response_json['session']['edition']).to eq 'Country Wide'
    end

  end
end