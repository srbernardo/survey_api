# frozen_string_literal: true

module Mutations
  class SurveyCreate < BaseMutation
    include Authorization

    description "Creates a new survey"

    field :survey, Types::SurveyType, null: false

    argument :title, String, required: true
    argument :open, Boolean, required: false

    def resolve(title:, open:)
      authorize_coordinator!

      survey = Survey.new(title:, open:, user_id: context[:current_user].id)
      raise GraphQL::ExecutionError.new "Error creating survey", extensions: survey.errors.to_hash unless survey.save

      { survey: survey }
    end
  end
end
