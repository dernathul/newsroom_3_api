RSpec.describe "POST '/api/v1/auth'", type: :request do
  let(:header) { { HTTP_ACCEPT: "application/json" } }

  describe "with valid credentials" do
    before do
      post '/api/v1/auth',
           params: {
             email: 'user@mail.com',
             password: 'password',
             password_confirmation: 'password'
           },
           headers: headers
    end

    it "returns a 200 response status" do
      expect(response_json["status"]).to eq "success"
    end

      it "returns a success message" do
      expect(response_json["status"]).to eq "success"
    end
  end

  context "when a user submits" do
    describe "a non-matching password confirmation" do
      before do
        post "/api/v1/auth",
             params: {
               email: "user@mail.com",
               password: "covfefe",
               password_confirmation: "password"
             },
            headers: headers
      end

      it "returns a 422 response status" do
        expect(response).to have_http_status 422
      end

      it "returns an error message" do
        expect(response_json["errors"]["password_confirmation"]).to eq ["doesn't match Password"]
      end
    end

    describe "an invalid email adress" do
      before do
          post '/api/v1/auth',
            params: {
          email: 'wrongmail.com',
          password: 'password',
          password_confirmation: 'password'
        },
        headers: headers
      end

      it 'returns an 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['is not an email']
      end
    end

    describe 'an already registered email' do
      let!(:registered_user) { create(:user, email: 'first.user@mail.com') }

      before do
        post '/api/v1/auth',
        params: {
          email: 'first.user@mail.com',
          password: 'password',
          password_confirmation: 'password'
        },
        headers: headers
      end

      it 'returns a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns am errpr message' do
        expect(response_json['errors']['email']).to eq ['has already been taken']
      end 
    end
  end 
end


