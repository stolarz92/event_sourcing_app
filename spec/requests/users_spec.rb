require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:valid_params) do
    { user: valid_payload }
  end

  describe "POST /users/create" do
    let(:user_params) do
      {
        name: 'Test Name',
        email: 'test@email.com',
        password: 'password'
      }
    end

    let(:valid_payload) { user_params }

    context 'with valid payload' do
      it 'creates new event' do
        post '/users/create', params: valid_params
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "DELETE /users/destroy" do
    let(:user) do
      User.new(
        name: 'Test Name',
        email: 'test@email.com',
        password_digest: 'password'
      )
    end

    before do
      user.save!
    end

    context 'with valid payload' do
      let(:valid_payload) { { id: user.id } }

      it 'destroys event' do
        delete "/users/destroy", params: valid_params
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
