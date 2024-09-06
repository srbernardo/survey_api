# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :option, String, null: false
    field :order, Integer, null: false
    field :survey_id, Integer, null: false
    field :choices, [Types::ChoiceType], null: false, description: "List of choices for this question"
    field :choice_answers, [Types::ChoiceAnswerType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
