require 'rails_helper'

RSpec.describe 'SurveyUpdate Mutation', type: :request do
  let(:survey) { create(:survey) }
  let(:query) do
    <<~GQL
      mutation($id: ID!, $title: String!, $open: Boolean) {
        surveyUpdate(input: { id: $id, title: $title, open: $open }) {
          survey {
            id
            title
            open
          }
        }
      }
    GQL
  end

  let(:variables) { { id: survey.id, title: Faker::Book.title , open: false } }
  let(:coordinator) { create(:user, :coordinator) }
  let(:token) { JWT.encode({ user_id: coordinator.id, exp: 1.hour.from_now.to_i }, 'secret', 'HS256') }

  context 'when the input is valid and the user is authorized' do
    it 'updates a survey and returns the survey data' do
      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Authorization': "Bearer #{token}", 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      data = json['data']['surveyUpdate']['survey']

      expect(response).to have_http_status(:success)
      expect(data['title']).to eq(variables[:title])
      expect(data['open']).to eq(variables[:open])
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
