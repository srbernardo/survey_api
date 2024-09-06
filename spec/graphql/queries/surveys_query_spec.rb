require 'rails_helper'

RSpec.describe 'Query surveys', type: :request do
  describe 'fetching all surveys' do
    let!(:surveys) { create_list(:survey, 3) }
    let(:query) do
      <<~GQL
        {
          surveys {
            id
            title
            open
          }
        }
      GQL
    end

    it 'returns all surveys' do
      post '/graphql', params: { query: query }.to_json, headers: { 'Content-Type': 'application/json' }
      json = JSON.parse(response.body)
      data = json['data']['surveys']

      expect(data.size).to eq(3)
      expect(data[0]['title']).to eq(surveys.first.title)
      expect(data[1]['title']).to eq(surveys.second.title)
      expect(data[2]['title']).to eq(surveys.last.title)
    end
  end
end
