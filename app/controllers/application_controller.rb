class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||=
      User.find_by_session_token(request.headers['sessionToken'])
  end

end
