# frozen_string_literal: true

module Mutations
  class ChoiceAnswerCreate < BaseMutation
    description "Creates a new choice_answer"

    field :choice_answer, Types::ChoiceAnswerType, null: false

    argument :user_id, ID, required: true
    argument :choice_id, ID, required: true

    def resolve(choice_id:, user_id:)
      choice_answer = ::ChoiceAnswer.new(choice_id:, user_id:)
      raise GraphQL::ExecutionError.new "Error creating choice_answer", extensions: choice_answer.errors.to_hash unless choice_answer.save
      raise GraphQL::ExecutionError.new "Error: Survey closed", extensions: choice_answer.errors.to_hash unless choice_answer.question.survey.open?

      { choice_answer: choice_answer }
    end
  end
end
