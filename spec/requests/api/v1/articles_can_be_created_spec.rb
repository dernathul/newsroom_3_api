describe 'POST /article', type: :request do
  describe 'successfull' do
    before do
      post '/api/v1/articles'
      @article = Article.new(title: "No more room in space", snippet: "Its all gone, sorry", content: "Govenor says this aint good")
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    it 'displays correct title' do
      expect(@article.title).to eq "No more room in space"
    end

    it 'displays correct snippet' do
      expect(@article.snippet).to eq "Its all gone, sorry"
    end

    it 'displays correct content' do
      expect(@article.content).to eq "Govenor says this aint good"
    end
  end

  describe 'unsuccessfull' do
    before do
      post '/api/v1/articles'
      @article = Article.new(title: "", snippet: "", content: "")
    end

    it 'displays error on empty title' do
      binding.pry
      expect(response.status).to eq 400
    end
  end
  
end