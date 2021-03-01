require 'rails_helper'

RSpec.describe 'oauth/tokens password grant flow', type: :request do
  context 'with valid username/password' do
    with :user
    with :application
    let(:params) do
      {
        client_id: application.uid,
        client_secret: application.secret,
        username: user.email,
        password: user.password,
        grant_type: 'password'
      }
    end
    let(:headers) { {} }
    let(:expected_response) do
      {
        access_token: @new_token.token,
        token_type: 'Bearer',
        expires_in: 'ignored',
        created_at: 'ignored'
      }.to_json
    end
    before do
      post '/oauth/token', params, headers
      @new_token = Doorkeeper::AccessToken.last
    end
    it { expect(response.status).to eq 200 }
    it { expect(response.body).to be_json_eql(expected_response).excluding('expires_in', 'created_at') }
  end
  context 'with invalid password' do
    with :user
    with :application
    let(:params) do
      {
        client_id: application.uid,
        client_secret: application.secret,
        username: user.email,
        password: 'invalid password',
        grant_type: 'password'
      }
    end
    let(:headers) { {} }
    before do
      post '/oauth/token', params, headers
    end
    it { expect(response.status).to eq 400 }
  end
  context 'with invalid username' do
    with :user
    with :application
    let(:params) do
      {
        client_id: application.uid,
        client_secret: application.secret,
        username: 'invalid username',
        password: 'invalid password',
        grant_type: 'password'
      }
    end
    let(:headers) { {} }
    before do
      post '/oauth/token', params, headers
    end
    it { expect(response.status).to eq 400 }
  end
end
