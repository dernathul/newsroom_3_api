RSpec.describe Api::V1::ArticlesController, type: :request do
  describe' GET /article/1 successfully' do
    let!(:article) { create(:article, title: 'NOSPACE', snippet: "You thought you liked space", content: "NOSPACE is where you want to be") }
    before do
      get "/api/v1/articles/#{article.id}"
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'should return article title' do
      expect(response_json)['article']['title'].to eq 'NOSPACE'
    end
  end
end