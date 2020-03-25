describe 'GET /articles', type: :request do
  describe'successfull' do
    
    let!(:articles) {create(:article)}
    let!(:articles2) {create(:article, title: 'NOSPACE', snippet: "You thought you liked space", content: "NOSPACE is where you want to be")}
    
    before do
      get '/api/v1/articles'
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end
    
    it 'returns correct number of articles' do
      expect(JSON.parse(response.body)["articles"].count).to eq 2
    end

    it 'checks if title is correct' do
      expect(JSON.parse(response.body)["articles"].first["title"]).to eq "SPACE"
    end

    it 'checks if snippet is correct' do
      expect(JSON.parse(response.body)["articles"].first["snippet"]).to eq "Is space the next place?"
    end

    it 'checks if content is correct' do
      expect(JSON.parse(response.body)["articles"].first["content"]).to eq "Lau has become the president of space."
    end
  
  end
end
