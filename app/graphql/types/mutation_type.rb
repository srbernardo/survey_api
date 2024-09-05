# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :choice_answer_create, mutation: Mutations::ChoiceAnswerCreate
    field :choice_respondent_update, mutation: Mutations::ChoiceRespondentUpdate
    field :multi_line_answer_create, mutation: Mutations::MultiLineAnswerCreate
    field :single_line_answer_create, mutation: Mutations::SingleLineAnswerCreate
    field :choice_update, mutation: Mutations::ChoiceUpdate
    field :question_update, mutation: Mutations::QuestionUpdate
    field :question_delete, mutation: Mutations::QuestionDelete
    field :choice_delete, mutation: Mutations::ChoiceDelete
    field :choice_create, mutation: Mutations::ChoiceCreate
    field :question_create, mutation: Mutations::QuestionCreate
    field :survey_delete, mutation: Mutations::SurveyDelete
    field :survey_update, mutation: Mutations::SurveyUpdate
    field :survey_create, mutation: Mutations::SurveyCreate
    field :user_create, mutation: Mutations::UserCreate
    field :login, mutation: Mutations::Login
  end
end
