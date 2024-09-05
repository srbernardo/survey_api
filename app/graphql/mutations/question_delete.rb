# frozen_string_literal: true

module Mutations
  class QuestionDelete < BaseMutation
    include Authorization

    description "Deletes a question by ID"

    field :message, String, null: false

    argument :id, ID, required: true

    def resolve(id:)
      authorize_coordinator!

      question = ::Question.find(id)
      raise GraphQL::ExecutionError.new "Error deleting question", extensions: question.errors.to_hash unless question.destroy!

      { message: 'Question deleted successfully'}
    end
  end
end
