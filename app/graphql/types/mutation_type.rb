# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :survey_delete, mutation: Mutations::SurveyDelete
    field :survey_update, mutation: Mutations::SurveyUpdate
    field :survey_create, mutation: Mutations::SurveyCreate
    field :user_create, mutation: Mutations::UserCreate
    field :login, mutation: Mutations::Login
  end
end
