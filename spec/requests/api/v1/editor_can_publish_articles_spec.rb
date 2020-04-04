RSpec.describe "PUT /articles", type: :request do
  let(:editor) { create(:user, role: "editor") }
  let(:editor_credentials) { editor.create_new_auth_token }
  let(:editor_headers) do
    { HTTP_ACCEPT: "application/json" }.merge!(editor_credentials)
  end

  let(:journalist) { create(:user, role: "journalist") }
  let(:journalist_credentials) { journalist.create_new_auth_token }
  let(:journalist_headers) do
    { HTTP_ACCEPT: "application/json" }.merge!(journalist_credentials)
  end

  let!(:articles2) do
    create(
      :article,
      :with_image,
      title: "NOSPACE",
      snippet: "You thought you liked space",
      content: "NOSPACE is where you want to be",
      category: "tech",
      premium: true,
      published: false,
    )
  end

  before { put "/api/v1/admin/#{Article.last.id}", params: { article: { published: true } }, headers: editor_headers }

  it "returns 200 status" do
    expect(response.status).to eq 200
  end

  it "should return a success message" do
    expect(response_json["message"]).to eq "Article is published"
  end

  it "editor can publish article" do
    expect(Article.last["published"]).to eq true
  end

  describe "journalist can not view unpublished articles" do
    before { put "/api/v1/admin/#{Article.last.id}", params: { article: { published: true } }, headers: journalist_headers }

    it "returns 401 status" do
      expect(response.status).to eq 401
    end

    it "journalist should not be allowed to publish" do
      expect(
        response_json["message"]
      ).to eq "You are not authenticated to publish an article"
    end
  end
end
