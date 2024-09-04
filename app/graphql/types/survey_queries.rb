module Types
  module SurveyQueries
    extend ActiveSupport::Concern

    included do
      field :surveys, [Types::SurveyType], null: false
      def surveys
        Survey.all
      end

      field :survey, Types::SurveyType, null: false do
        argument :id, GraphQL::Types::ID, required: true
      end

      def survey(id:)
        begin
          Survey.find(id)
        rescue ActiveRecord::RecordNotFound
          raise GraphQL::ExecutionError.new("Survey not found with ID #{id}")
        end
      end
    end
  end
end
