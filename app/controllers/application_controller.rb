class ApplicationController < ActionController::API
  
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  
  # rescue_from Pundit::NotAuthorizedError, with :not_authorized
    
  # def not_authorized
  #   render json: { error: 'Not Authorized'}, status 404
  # end
end
