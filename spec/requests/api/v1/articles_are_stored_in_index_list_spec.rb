describe 'GET /articles', type: :request do
  describe 'successfull' do
    let!(:articles) { create(:article) }
    let!(:articles2) do
      create(
        :article,
        :with_image,
        title: 'NOSPACE',
        snippet: 'You thought you liked space',
        content: 'NOSPACE is where you want to be',
        category: 'tech'
      )
    end

    before { get '/api/v1/articles' }

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    it 'returns correct number of articles' do
      expect(JSON.parse(response.body)['articles'].count).to eq 2
    end

    it 'checks if title is correct' do
      binding.pry
      expect(JSON.parse(response.body)['articles'].second['title']).to eq 'SPACE'
    end

    it 'checks if snippet is correct' do
      expect(
        JSON.parse(response.body)['articles'].second['snippet']
      ).to eq 'Is space the next place?'
    end
  end
end
