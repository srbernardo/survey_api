require 'rails_helper'

RSpec.describe 'QuestionUpdate Mutation', type: :request do
  let(:question) { create(:question) }
  let(:query) do
    <<~GQL
      mutation($id: ID!, $title: String!, $option: Int!, $order: Int!) {
        questionUpdate(input: { id: $id, title: $title, option: $option, order: $order }) {
          question {
            id
            title
            order
            option
          }
        }
      }
    GQL
  end

  let(:variables) { { id: question.id, title: Faker::Book.title, option: 2, order: 2 } }
  let(:coordinator) { create(:user, :coordinator) }
  let(:token) { JWT.encode({ user_id: coordinator.id, exp: 1.hour.from_now.to_i }, 'secret', 'HS256') }

  context 'when the input is valid and the user is authorized' do
    it 'updates a question and returns the question data' do
      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Authorization': "Bearer #{token}", 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      data = json['data']['questionUpdate']['question']

      expect(response).to have_http_status(:success)
      expect(data['title']).to eq(variables[:title])
      expect(data['order']).to eq(variables[:order])
      expect(data['option']).to eq("single_line_answer")
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
