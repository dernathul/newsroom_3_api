describe 'GET /articles', type: :request do
  describe'successfull' do
    before do
      get '/api/v1/articles'
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end
  end
end
