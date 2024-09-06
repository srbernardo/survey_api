# frozen_string_literal: true

module Mutations
  class MultiLineAnswerCreate < BaseMutation
    description "Creates a new multi_line_answer"

    field :multi_line_answer, Types::MultiLineAnswerType, null: false

    argument :value, String, required: true
    argument :question_id, ID, required: true
    argument :user_id, ID, required: true

    def resolve(value:, question_id:, user_id:)
      multi_line_answer = ::MultiLineAnswer.new(value:, question_id:, user_id:)

      raise GraphQL::ExecutionError.new "Error creating multi_line_answer", extensions: multi_line_answer.errors.to_hash unless multi_line_answer.save
      raise GraphQL::ExecutionError.new "Error: Survey closed", extensions: multi_line_answer.errors.to_hash unless multi_line_answer.question.survey.open?

      { multi_line_answer: multi_line_answer }
    end
  end
end
