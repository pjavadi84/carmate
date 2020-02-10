class UsersController < ApplicationController


  # GET: /users/new

  get "/signup" do
    if !logged_in?
      erb :"/users/new.html", locals: {message: "can't logged in. Please create an account"}
    else
      redirect to "/cars"
    end
  end

  # POST: /users
  post "/signup" do
    if params[:first_name].empty? || params[:last_name].empty? || params[:username].empty? || params[:password].empty?
      redirect to '/new'
    else
      @user = User.new(:first_name =>params[:first_name], :last_name => params[:last_name], :username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/cars'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login.html'
    else
      redirect to '/cars'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/#{user.id}/cars"
    else
      redirect to "/signup"
    end
  end

  # # GET: /users/5
  # get "/users/:id" do
  #   erb :"/users/show.html"
  # end

  # # GET: /users/5/edit
  # get "/users/:id/edit" do
  #   erb :"/users/edit.html"
  # end

  # # PATCH: /users/5
  # patch "/users/:id" do
  #   redirect "/users/:id"
  # end

  # # DELETE: /users/5/delete
  # delete "/users/:id/delete" do
  #   redirect "/users"
  # end

  #LOGOUT: /users/5/logout
  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
