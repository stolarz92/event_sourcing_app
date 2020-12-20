require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:valid_params) do
    { user: valid_payload }
  end

  describe "POST /users/create" do
    let(:valid_payload) do
      {
        name: 'Test Name',
        email: 'test@email.com',
        password: 'password'
      }
    end

    context 'with valid payload' do
      it 'creates new event' do
        expect { post '/users/create', params: valid_params }
          .to change { User.count }.by(1)
          .and change { Events::User::BaseEvent.count }.by(1)

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
        expect { delete "/users/destroy", params: valid_params }
          .to change { Events::User::BaseEvent.count }.by(1)

        expect { user.reload.deleted }
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
