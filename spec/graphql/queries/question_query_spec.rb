require 'rails_helper'

RSpec.describe 'Query Question', type: :request do
  describe 'fetching a single question' do
    let!(:question) { create(:question) }
    let(:query) do
      <<~GQL
        query($id: ID!) {
          question(id: $id) {
            id
            title
            order
            option
            surveyId
          }
        }
      GQL
    end

    context 'when the question exists' do
      it 'returns the correct question' do
        post '/graphql', params: { query: query, variables: { id: question.id } }.to_json, headers: { 'Content-Type': 'application/json' }
        json = JSON.parse(response.body)
        data = json['data']['question']

        expect(data['id']).to eq(question.id.to_s)
        expect(data['title']).to eq(question.title)
        expect(data['order']).to eq(question.order)
        expect(data['option']).to eq(question.option)
        expect(data['surveyId']).to eq(question.survey_id)
      end
    end

    context 'when the question does not exist' do
      it 'returns an error' do
        post '/graphql', params: { query: query, variables: { id: -1 } }.to_json, headers: { 'Content-Type': 'application/json' }
        json = JSON.parse(response.body)
        errors = json['errors']

        expect(errors).not_to be_empty
        expect(errors.first['message']).to eq("Question not found with ID -1")
      end
    end
  end
end
