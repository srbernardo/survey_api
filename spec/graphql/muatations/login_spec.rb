require "rails_helper"

RSpec.describe 'mutation login', type: :request do
  it 'authenticates the account returning a token' do
    user = create(:user)

    post '/graphql', params: { query: query(email: user.email, password: user.password) }
    json = JSON.parse(response.body)
    data = json['data']

    expect(data['login']).to have_key('token')
    expect(data['login']['token']).not_to be_nil
  end

  it 'returns an error when authenticate fails' do
    create(:user)

    post '/graphql', params: { query: query(email: "error", password: "error") }
    json = JSON.parse(response.body)

    expect(json).to have_key('errors')
    expect(json['errors'].first['message']).to eq("Invalid email or password")
  end

  def query(email:, password:)
    <<~GQL
      mutation {
        login(
          input: {
            email: "#{email}",
            password: "#{password}"
          }
        ) {
          token
        }
      }
    GQL
  end
end
