# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include Types::SurveyQueries

    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :surveys_lists, Types::SurveysListsType, null: false, description: "Return both completed and incomplete surveys"
    def surveys_lists
      {
        completed_surveys: Survey.all.select(&:completed?),
        open_surveys: Survey.all.select(&:open?),
        close_surveys: Survey.all.reject(&:open?)
      }
    end
  end
end
