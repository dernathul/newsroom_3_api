RSpec.describe "GET /articles", type: :request do
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

  let!(:articles) { create(:article) }
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
  let!(:articles3) do
    create(
      :article,
      :with_image,
      title: "SPACE",
      snippet: "You thought you did not liked space",
      content: "SPACE is where you want to be",
      category: "sports",
      premium: true,
      published: false,
    )
  end

  before { get "/api/v1/admin", headers: editor_headers }

  it "returns 200 status" do
    expect(response.status).to eq 200
  end

  it "editor should see all unpublished articles" do
    expect(
      response_json["articles"].count
    ).to eq 2
  end

  it "should return article title" do
    expect(response_json["articles"][0]["title"]).to eq "NOSPACE"
  end

  it "should return article snippet" do
    expect(
      response_json["articles"][0]["snippet"]

    ).to eq "You thought you liked space"
  end

  it "should return article content" do
    expect(
      response_json["articles"][0]["content"]
    ).to eq "NOSPACE is where you want to be"
  end

  it "should return article category" do
    expect(response_json["articles"][0]["category"]).to eq "tech"
  end

  describe "journalist can not view unpublished articles" do
    before { get "/api/v1/admin", headers: journalist_headers }

    it "returns 401 status" do
      expect(response.status).to eq 401
    end

    it "journalist should not see articles" do
      expect(
        response_json["message"]
      ).to eq "You are not authenticated to view unpublished articles"
    end
  end
end
