# frozen_string_literal: true

module Types
  class ChoiceType < Types::BaseObject
    field :id, ID, null: false
    field :value, String
    field :question_id, Integer, null: false
    field :choice_answers, [Types::ChoiceAnswerType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def choice_answers
      object.choice_answers
    end
  end
end
