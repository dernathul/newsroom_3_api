describe 'POST /article', type: :request do
  describe 'successfull' do
    before do
      post '/api/v1/articles'
      @article = Article.new(title: "No more room in space", snippet: "Its all gone, sorry", content: "Govenor says this aint good")
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    it 'title is not blank' do
      binding.pry
      expect(@article.title).to eq "No more room in space"
    end
  end
  
end