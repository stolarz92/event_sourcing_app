require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:valid_payload) do
    {
      name: 'Test Name',
      email: 'test@email.com',
      password: 'password'
    }
  end

  let(:valid_params) do
    { user: valid_payload }
  end

  describe "POST /users/create" do
    context 'with valid payload' do
      it 'creates new event' do
        post '/users/create', params: valid_params
        expect(response).to have_http_status(:created)
      end
    end
  end
end
