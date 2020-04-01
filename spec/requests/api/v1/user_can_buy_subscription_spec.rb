require 'stripe_mock'

RSpec.describe 'POST api/v1/subscriptions', type: :request do
  let!(:stripe_helper) { StripeMock.create_test_helper }
  before(:each) { StripeMock.start }
  after(:each) { StripeMock.stop }

  let(:card_token) { stripe_helper.generate_card_token }
  let(:invalid_token) { '123456789' }

  let(:product) { stripe_helper.create_product }
  let!(:plan) { stripe_helper.create_plan(
      id: 'year_subscription',
      amount: 49_900,
      currency: 'usd',
      interval: 'year',
      interval_count: 1,
      name: 'Year subscription',
      product: product.id
    ) }

  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'successfully with valid stripe token' do
    before do
      post '/api/v1/subscriptions',
           params: { stripetoken: card_token, email: user.email },
           headers: headers
      user.reload
    end

    it 'responds with a success status' do
      expect(response).to have_http_status 200
    end

    it 'responds with a success message' do
      expect(response_json['status']).to eq 'paid'
    end

    it 'role is set updated to subscriber' do
      expect(user.role).to eq 'subscriber'
    end
  end

  describe 'unsuccessfully' do
    describe 'with invalid token' do
      before do
        post '/api/v1/subscriptions',
             params: { stripetoken: invalid_token, email: user.email },
             headers: headers
      end

      it 'to have response status 400' do
        expect(response).to have_http_status 400
      end

      it 'receives message about invalid token' do
        expect(
          response_json['error_message']
        ).to eq 'Invalid token id: 123456789'
      end

      it 'does not change the users role' do
        expect(user.role).to eq 'reg_user'
      end
    end

    describe 'with no stripe token' do
      before { post '/api/v1/subscriptions', headers: headers }

      it 'to have response status 400' do
        expect(response).to have_http_status 400
      end

      it 'receives error message about no token sent' do
        expect(
          response_json['error_message']
        ).to eq 'No Stripe token sent with request'
      end
    end

    describe 'when user is not signed in' do
      before do
        post '/api/v1/subscriptions', params: { stripetoken: card_token }
      end

      it 'returns not authorized reponse status' do
        expect(response).to have_http_status 401
      end

      it 'returns message to authenticate first' do
        expect(
          response_json['errors'][0]
        ).to eq 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'when Stripe desclines subscription for user' do
      before do
        custom_error = StandardError.new('Subscription could not be created')
        StripeMock.prepare_error(custom_error, :create_subscription)

        post '/api/v1/subscriptions',
             params: { stripetoken: card_token, email: user.email },
             headers: headers
      end

      it 'returns a response status 400' do
        expect(response).to have_http_status 400
      end

      it 'returns error message that subscription could not be created' do
        expect(
          response_json['error_message']
        ).to eq 'Subscription could not be created'
      end
    end
  end
end
