# frozen_string_literal: true

module Mutations
  class ChoiceCreate < BaseMutation
    include Authorization

    description "Creates a new choice"

    field :choice, Types::ChoiceType, null: false

    argument :value, String, required: true
    argument :question_id, ID, required: true

    def resolve(value:, question_id:)
      authorize_coordinator!

      choice = ::Choice.new(value:, question_id:)
      raise GraphQL::ExecutionError.new "Error creating choice", extensions: choice.errors.to_hash unless choice.save

      { choice: choice }
    end
  end
end
