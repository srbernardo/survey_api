# frozen_string_literal: true

module Mutations
  class QuestionUpdate < BaseMutation
    include Authorization

    description "Updates a question by id"

    field :question, Types::QuestionType, null: false

    argument :id, ID, required: true
    argument :title, String, required: true
    argument :option, Integer, required: true

    def resolve(id:, question_input:)
      authorize_coordinator!

      question = ::Question.find(id)
      raise GraphQL::ExecutionError.new "Error updating question", extensions: question.errors.to_hash unless question.update(title:, option:)

      { question: question }
    end
  end
end
