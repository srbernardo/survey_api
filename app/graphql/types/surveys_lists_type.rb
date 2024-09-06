module Types
  class SurveysListsType < Types::BaseObject
    field :open_surveys, [Types::SurveyType], null: false, description: "List of open surveys"
    field :close_surveys, [Types::SurveyType], null: false, description: "List of close surveys"
  end
end
