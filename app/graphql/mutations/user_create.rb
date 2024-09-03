# frozen_string_literal: true

module Mutations
  class UserCreate < BaseMutation
    description "Creates a new user"

    field :user, Types::UserType, null: false

    argument :email, String, required: true
    argument :password, String, required: true
    argument :role, Integer, required: true

    def resolve(email:, password:, role:)
      user = ::User.new(email:, password:, role:)
      raise GraphQL::ExecutionError.new "Error creating user", extensions: user.errors.to_hash unless user.save

      { user: user }
    end
  end
end
