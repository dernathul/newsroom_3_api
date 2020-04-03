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
    )
  end

  it "returns 200 status" do
    expect(response.status).to eq 200
  end

  it "displays correct title" do
    expect(
      response.request.params["article"]["title"]
    ).to eq "No more room in space"
  end

  it "displays correct snippet" do
    expect(
      response.request.params["article"]["snippet"]
    ).to eq "Its all gone, sorry"
  end

  it "displays correct content" do
    expect(
      response.request.params["article"]["content"]
    ).to eq "Govenor says this aint good"
  end

  it "displays correct category" do
    expect(response.request.params["article"]["category"]).to eq "tech"
  end
end
