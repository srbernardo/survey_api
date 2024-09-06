require 'rails_helper'

RSpec.describe 'MultiLineAnswerCreate Mutation', type: :request do
  let(:query) do
    <<~GQL
      mutation($value: String!, $userId: ID!, $questionId: ID!) {
        multiLineAnswerCreate(input: { value: $value, userId: $userId, questionId: $questionId }) {
          multiLineAnswer {
            id
            value
            userId
            questionId
          }
        }
      }
    GQL
  end

  context 'when the input is valid' do
    it 'creates a new multiLineAnswer and returns the multiLineAnswer data' do
      user = create(:user )
      question = create(:question)

      variables = {
        value: Faker::Book.title,
        userId: user.id,
        questionId: question.id
      }

      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      data = json['data']['multiLineAnswerCreate']['multiLineAnswer']

      expect(response).to have_http_status(:success)
      expect(data['value']).to eq(variables[:value])
      expect(data['userId']).to eq(variables[:userId])
      expect(data['questionId']).to eq(variables[:questionId])
    end
  end

  context 'when the input is invalid' do
    it 'returns an error' do
      variables = {
        value: "",
        userId: "",
        questionId: ""
      }

      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      errors = json['errors']

      expect(errors).not_to be_nil
      expect(errors.first['message']).to include("Error creating multi_line_answer")
    end
  end

  context 'when the survey is closed' do
    it 'returns an error' do
      user = create(:user)
      survey = create(:survey, open: false)
      question = create(:question, survey:)

      variables = {
        value: Faker::Book.title,
        userId: user.id,
        questionId: question.id
      }

      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      errors = json['errors']

      expect(errors).not_to be_nil
      expect(errors.first['message']).to include("Error: Survey closed")
    end
  end
end
