# frozen_string_literal: true

module Mutations
  class Login < BaseMutation
    description "Logs in a user and returns user data if successful"

    field :token, String, null: false

    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.valid_password?(password)
        token = JWT.encode({ user_id: user.id, exp: 1.hour.from_now.to_i }, 'secret', 'HS256')
        { token: token }
      else
        raise GraphQL::ExecutionError, 'Invalid email or password'
      end
    end
  end
end
