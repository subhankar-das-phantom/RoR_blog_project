class Api::V1::AuthenticationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate
    user = User.find_by(email: params[:email])
    
    if user&.valid_password?(params[:password])
      token = JWT.encode(
        { 
          user_id: user.id, 
          exp: 24.hours.from_now.to_i 
        },
        Rails.application.secret_key_base,
        'HS256'
      )
      
      render json: {
        token: token,
        user: {
          id: user.id,
          email: user.email,
          name: user.full_name
        }
      }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end