Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  devise_for :users
  post "/graphql", to: "graphql#execute"

  get "up" => "rails/health#show", as: :rails_health_check
end
