require 'rails_helper'

RSpec.describe 'ChoiceAnswerCreate Mutation', type: :request do
  let(:query) do
    <<~GQL
      mutation($userId: ID!, $choiceId: ID!) {
        choiceAnswerCreate(input: { userId: $userId, choiceId: $choiceId }) {
          choiceAnswer {
            id
            userId
            choiceId
          }
        }
      }
    GQL
  end

  context 'when the input is valid' do
    it 'creates a new choiceAnswer and returns the choiceAnswer data' do
      user = create(:user )
      choice = create(:choice )

      variables = {
        userId: user.id,
        choiceId: choice.id
      }

      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      data = json['data']['choiceAnswerCreate']['choiceAnswer']

      expect(response).to have_http_status(:success)
      expect(data['userId']).to eq(variables[:userId])
      expect(data['choiceId']).to eq(variables[:choiceId])
    end
  end

  context 'when the input is invalid' do
    it 'returns an error' do
      variables = {
        userId: '',
        choiceId: ''
      }

      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      errors = json['errors']

      expect(errors).not_to be_nil
      expect(errors.first['message']).to include("Error")
    end
  end

  context 'when the survey is closed' do
    it 'returns an error' do
      user = create(:user)
      survey = create(:survey, open: false)
      question = create(:question, survey:)
      choice = create(:choice, question:)

      variables = {
        userId: user.id,
        choiceId: choice.id
      }

      post '/graphql', params: { query: query, variables: variables }.to_json, headers: { 'Content-Type': 'application/json' }

      json = JSON.parse(response.body)
      errors = json['errors']

      expect(errors).not_to be_nil
      expect(errors.first['message']).to include("Error: Survey closed")
    end
  end
end
