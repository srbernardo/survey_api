# frozen_string_literal: true

module Types
  class ChoiceAnswerType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :choice_id, Integer, null: false
    field :choice, Types::ChoiceType, null: false
    field :question, Types::QuestionType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
