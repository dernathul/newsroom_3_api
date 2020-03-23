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
      expect(response.request.params['title']).to eq "No more room in space"
    end

    it 'displays correct snippet' do
      expect(response.request.params['snippet']).to eq "Its all gone, sorry"
    end
    it 'displays correct content' do
      expect(response.request.params['content']).to eq "Govenor says this aint good"
    end
  end

  describe 'sad path' do
    before do
      post '/api/v1/articles',
      params: {
        title: "",
        snippet: "this is text",
        content: "content text"
      }
    end

    it 'displays error of incomplete article' do
      expect(response.status).to eq 206
    end
    
    it 'displays error message on empty title' do
      expect(response.body).to include("Your article could not be saved")
    end

    before do
      post '/api/v1/articles',
      params: {
        title: "Cool title",
        snippet: "",
        content: "content text"
      }
    end

    it 'displays error of incomplete article' do
      expect(response.status).to eq 206
    end
    
    it 'displays error message on empty snippet' do
      expect(response.body).to include("Your article could not be saved")
    end

    before do
      post '/api/v1/articles',
      params: {
        title: "Yes a title",
        snippet: "this is text",
        content: ""
      }
    end

    it 'displays error of incomplete article' do
      expect(response.status).to eq 206
    end
    
    it 'displays error message on empty content' do
      expect(response.body).to include("Your article could not be saved")
    end
  end
end
  