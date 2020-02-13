require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "carmate_secret"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect to "/users/#{current_user.id}"
    else
      erb :welcome
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] #(memoization)
    end

    def edit_authorized?(car)
      car.user == current_user
    end
  end

end
