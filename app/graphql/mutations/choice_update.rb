# frozen_string_literal: true

module Mutations
  class ChoiceUpdate < BaseMutation
    include Authorization

    description "Updates a choice by id"

    field :choice, Types::ChoiceType, null: false

    argument :id, ID, required: true
    argument :value, String, required: false
    argument :marked, Boolean, required: false

    def resolve(id:, value:, marked:)
      authorize_coordinator!

      choice = ::Choice.find(id)
      raise GraphQL::ExecutionError.new "Error updating choice", extensions: choice.errors.to_hash unless choice.update(value:, marked:)

      { choice: choice }
    end
  end
end
