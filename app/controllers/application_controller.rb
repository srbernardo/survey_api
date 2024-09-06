class ApplicationController < ActionController::API
  private

  def current_user
    token = request.headers['Authorization'].to_s.split(' ').last
    return unless token

    decoded_token = JWT.decode(token, 'secret', true, algorithm: 'HS256')
    User.find(decoded_token[0]['user_id'])
  end
end
