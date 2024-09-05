# frozen_string_literal: true

module Mutations
  class SurveyUpdate < BaseMutation
    include Authorization

    description "Updates a survey by id"

    field :survey, Types::SurveyType, null: false

    argument :id, ID, required: true
    argument :title, String, required: true
    argument :open, Boolean, required: false

    def resolve(id:, title:, open:)
      authorize_coordinator!

      survey = ::Survey.find(id)
      raise GraphQL::ExecutionError.new "Error updating survey", extensions: survey.errors.to_hash unless survey.update(title:, open:)

      { survey: survey }
    end
  end
end
