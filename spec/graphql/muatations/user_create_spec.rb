require 'rails_helper'

RSpec.describe 'UserCreate Mutation', type: :request do
  describe 'creating a new user' do
    let(:query) do
      <<~GQL
        mutation($email: String!, $password: String!, $role: Int!) {
          userCreate(input: { email: $email, password: $password, role: $role }) {
            user {
              id
              email
              role
            }
          }
        }
      GQL
    end

    context 'when the input is valid' do
      it 'creates a new user and returns the user data' do
        variables = {
          email: "test@example.com",
          password: "123456",
          role: 1
        }

        post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

        json = JSON.parse(response.body)
        data = json['data']['userCreate']['user']

        expect(response).to have_http_status(:success)
        expect(data['email']).to eq(variables[:email])
        expect(data['role']).to eq("coordinator")
      end
    end

    context 'when the input is invalid' do
      it 'returns an error when the email is missing' do
        variables = {
          email: "",
          password: "123456",
          role: 1
        }

        post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

        json = JSON.parse(response.body)
        errors = json['errors']

        expect(errors).not_to be_nil
        expect(errors.first['message']).to eq("Error creating user")
      end
    end
  end
end
