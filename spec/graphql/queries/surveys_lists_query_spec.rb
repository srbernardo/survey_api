require 'rails_helper'

RSpec.describe 'Query surveys_lists', type: :request do
  let!(:open_survey) { create(:survey, open: true) }
  let!(:close_survey) { create(:survey, open: false) }
  let(:query) do
    <<~GQL
      {
        surveysLists {
          openSurveys {
            id
            title
          }
          closeSurveys {
            id
            title
          }
        }
      }
    GQL
  end

  it 'returns the lists of open and close surveys' do
    post '/graphql', params: { query: query }.to_json, headers: { 'Content-Type': 'application/json' }

    json = JSON.parse(response.body)
    data = json['data']['surveysLists']

    expect(data['openSurveys']).to include(
      'id' => open_survey.id.to_s,
      'title' => open_survey.title
    )
    expect(data['closeSurveys']).to include(
      'id' => close_survey.id.to_s,
      'title' => close_survey.title
    )
  end
end
