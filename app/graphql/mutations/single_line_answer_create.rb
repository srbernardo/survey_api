# frozen_string_literal: true

module Mutations
  class SingleLineAnswerCreate < BaseMutation
    description "Creates a new single_line_answer"

    field :single_line_answer, Types::SingleLineAnswerType, null: false

    argument :value, String, required: true
    argument :question_id, ID, required: true

    def resolve(value:, question_id:)
      single_line_answer = ::SingleLineAnswer.new(value:, question_id:)

      raise GraphQL::ExecutionError.new "Error creating single_line_answer", extensions: single_line_answer.errors.to_hash unless single_line_answer.save
      raise GraphQL::ExecutionError.new "Error: Survey closed", extensions: single_line_answer.errors.to_hash unless single_line_answer.question.survey.open?

      { single_line_answer: single_line_answer }
    end
  end
end
