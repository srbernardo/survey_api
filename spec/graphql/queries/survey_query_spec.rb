require 'rails_helper'

RSpec.describe 'Query survey', type: :request do
  describe 'fetching a single survey' do
    let!(:survey) { create(:survey) }
    let(:query) do
      <<~GQL
        query($id: ID!) {
          survey(id: $id) {
            id
            title
            open
          }
        }
      GQL
    end

    context 'when the survey exists' do
      it 'returns the correct survey' do
        post '/graphql', params: { query: query, variables: { id: survey.id } }.to_json, headers: { 'Content-Type': 'application/json' }
        json = JSON.parse(response.body)
        data = json['data']['survey']

        expect(data['id']).to eq(survey.id.to_s)
        expect(data['title']).to eq(survey.title)
      end
    end

    context 'when the survey does not exist' do
      it 'returns an error' do
        post '/graphql', params: { query: query, variables: { id: -1 } }.to_json, headers: { 'Content-Type': 'application/json' }
        json = JSON.parse(response.body)
        errors = json['errors']

        expect(errors).not_to be_empty
        expect(errors.first['message']).to eq("Survey not found with ID -1")
      end
    end
  end
end
