module Types
  class SurveysListsType < Types::BaseObject
    field :completed_surveys, [Types::SurveyType], null: false, description: "List of completed surveys"
    field :open_surveys, [Types::SurveyType], null: false, description: "List of incomplete surveys"
    field :close_surveys, [Types::SurveyType], null: false, description: "List of incomplete surveys"
  end
end
