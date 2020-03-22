RSpec.describe 'POST /article', type: :request do
  describe 'successfull' do
    before do
      post '/api/v1/articles',
      params: {
        title: "No more room in space",
        snippet: "Its all gone, sorry",
        content: "Govenor says this aint good"
      }
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    it 'displays correct title' do
      binding.pry
      expect(article.title).to render_template(:title)
    end

    it 'displays correct snippet' do
      expect(@filtered_parameters).to eq "Its all gone, sorry"
    end
    it 'displays correct content' do
      expect(params.content).to eq "Govenor says this aint good"
    end
  end

  describe 'ungood' do
    before do
      post '/api/v1/articles',
      params: {
        title: "",
        snippet: "",
        content: ""
      }
    end

    it 'displays error on empty title' do
      expect(response.status).to eq 400
    end
  end
  
end