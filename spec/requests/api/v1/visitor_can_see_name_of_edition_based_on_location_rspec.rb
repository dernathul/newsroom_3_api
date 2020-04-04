RSpec.describe Api::V1::Sessionscontroller, type: :request do
  describe ' POST /api/v1/sessions successfully' do

    it 'returns a session object with location and edition name' do
      post '/api/v1/sessions', params: {location: { latitude: 57.72, longitude: 11.93 }}
      expect(response_json['session']['edition']).to eq 'Gothenburg'
    end
  end
end