# frozen_string_literal: true

module Types
  class ChoiceType < Types::BaseObject
    field :id, ID, null: false
    field :value, String
    field :marked, Boolean
    field :question_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
