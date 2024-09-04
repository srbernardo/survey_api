# frozen_string_literal: true

module Mutations
  class SurveyDelete < BaseMutation
    include Authorization

    description "Deletes a survey by ID"

    field :message, String, null: false

    argument :id, ID, required: true

    def resolve(id:)
      authorize_coordinator!

      survey = ::Survey.find(id)
      raise GraphQL::ExecutionError.new "Error deleting survey", extensions: survey.errors.to_hash unless survey.destroy!

      { message: 'Survey deleted successfully'}
    end
  end
end
