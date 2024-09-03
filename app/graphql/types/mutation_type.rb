# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :user_create, mutation: Mutations::UserCreate
    field :login, mutation: Mutations::Login
  end
end
