# frozen_string_literal: true

module Mutations
  class ChoiceRespondentUpdate < BaseMutation
    description "Updates a choice_respondent by id"

    field :choice, Types::ChoiceType, null: false

    argument :id, ID, required: true
    argument :marked, Boolean, required: true

    def resolve(id:, marked:)
      choice = ::Choice.find(id)

      raise GraphQL::ExecutionError.new "Error: Survey closed", extensions: choice.errors.to_hash unless choice.question.survey.open?
      raise GraphQL::ExecutionError.new "Error updating choice", extensions: choice.errors.to_hash unless choice.update(marked:)

      { choice: choice }
    end
  end
end
