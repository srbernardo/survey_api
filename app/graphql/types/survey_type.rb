# frozen_string_literal: true

module Types
  class SurveyType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :user_id, Integer, null: false
    field :questions, [QuestionType], null: false, description: "List of questions for this Survey"
    field :result, GraphQL::Types::JSON, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def result
      object.result
    end
  end
end
