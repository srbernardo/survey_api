# frozen_string_literal: true

module Mutations
  class ChoiceDelete < BaseMutation
    include Authorization

    description "Deletes a choice by ID"

    field :message, String, null: false

    argument :id, ID, required: true

    def resolve(id:)
      authorize_coordinator!

      choice = ::Choice.find(id)
      raise GraphQL::ExecutionError.new "Error deleting choice", extensions: choice.errors.to_hash unless choice.destroy!

      { message: 'Choice deleted successfully'}
    end
  end
end
