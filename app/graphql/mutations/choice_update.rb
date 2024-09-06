# frozen_string_literal: true

module Mutations
  class ChoiceUpdate < BaseMutation
    include Authorization

    description "Updates a choice by id"

    field :choice, Types::ChoiceType, null: false

    argument :id, ID, required: true
    argument :value, String, required: false

    def resolve(id:, value:)
      authorize_coordinator!

      choice = ::Choice.find(id)
      raise GraphQL::ExecutionError.new "Error updating choice", extensions: choice.errors.to_hash unless choice.update(value:)

      { choice: choice }
    end
  end
end
