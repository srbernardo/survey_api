# frozen_string_literal: true

module Mutations
  class QuestionCreate < BaseMutation
    include Authorization

    description "Creates a new question"

    field :question, Types::QuestionType, null: false

    argument :title, String, required: true
    argument :option, Int, required: true
    argument :order, Int, required: true
    argument :survey_id, ID, required: true

    def resolve(title:, option:, order:, survey_id:)
      authorize_coordinator!

      question = ::Question.new(title:, option:, order:, survey_id:)
      raise GraphQL::ExecutionError.new "Error creating question", extensions: question.errors.to_hash unless question.save

      { question: question }
    end
  end
end
