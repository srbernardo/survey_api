require 'rails_helper'

RSpec.describe 'QuestionDelete Mutation', type: :request do
  let(:question) { create(:question) }
  let(:query) do
    <<~GQL
      mutation($id: ID!) {
        questionDelete(input: { id: $id }) {
          message
        }
      }
    GQL
  end

  let(:variables) { { id: question.id } }
  let(:coordinator) { create(:user, :coordinator) }
  let(:token) { JWT.encode({ user_id: coordinator.id, exp: 1.hour.from_now.to_i }, 'secret', 'HS256') }

  context 'when the input is valid and the user is authorized' do
    it 'deletes a question and returns a message' do
      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Authorization': "Bearer #{token}", 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      data = json['data']['questionDelete']

      expect(response).to have_http_status(:success)
      expect(data['message']).to eq('Question deleted successfully')
    end
  end

  context 'when the user is not authorized' do
    it 'returns an error' do
      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      errors = json['errors']

      expect(errors).not_to be_nil
      expect(errors.first['message']).to include("You do not have permission to perform this action")
    end
  end
end
