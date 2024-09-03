module Authorization
  def authorize_coordinator!
    user = context[:current_user]
    raise GraphQL::ExecutionError, "You do not have permission to perform this action" unless user&.coordinator?
  end
end
