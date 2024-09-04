# frozen_string_literal: true

module Mutations
  class SurveyCreate < BaseMutation
    include Authorization

    description "Creates a new survey"

    field :survey, Types::SurveyType, null: false

    argument :title, String, required: true

    def resolve(title:)
      authorize_coordinator!

      survey = Survey.new(title:, user_id: 1)
      raise GraphQL::ExecutionError.new "Error creating survey", extensions: survey.errors.to_hash unless survey.save

      { survey: survey }
    end
  end
end
