require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  def current_user
    User.find_by(password_digest: session[:user_id])
end

def logged_in?
    session.key?(:user_id)
end

end
