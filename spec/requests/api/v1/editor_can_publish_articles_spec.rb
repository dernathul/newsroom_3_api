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

  before { put "/api/v1/admin/**", headers: editor_headers }

  it "returns 200 status" do
    expect(response.status).to eq 200
  end

  it "should return a success message" do
    expect(response_json["message"]
    ).to eq "Article is published"
  end
end