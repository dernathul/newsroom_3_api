describe 'GET /articles', type: :request do
  describe'successfull' do
    let!(:articles) {5.times {create(:article)}}
    before do
      get '/api/v1/articles'
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    it 'returns correct number of articles' do
      expect(JSON.parse(response.body)["articles"].count).to eq 5
    end


  end
end
