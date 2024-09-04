# frozen_string_literal: true

module Mutations
  class SurveyUpdate < BaseMutation
    include Authorization

    description "Updates a survey by id"

    field :survey, Types::SurveyType, null: false

    argument :id, ID, required: true
    argument :title, String, required: true

    def resolve(id:, title:)
      authorize_coordinator!

      survey = ::Survey.find(id)
      raise GraphQL::ExecutionError.new "Error updating survey", extensions: survey.errors.to_hash unless survey.update(title:)

      { survey: survey }
    end
  end
end
