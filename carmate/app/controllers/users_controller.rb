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
  post "/users" do
    if params[:first_name].empty? || params[:last_name].empty? || params[:username].empty? || params[:password].empty?
      redirect to '/new'
    else
      if User.find_by(username: params[:username])
        redirect to '/login'
      else
        @user = User.new(:first_name =>params[:first_name], :last_name => params[:last_name], :username => params[:username], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to "users/#{@user.id}"
      end
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login.html'
    else
      redirect to '/cars/show.html'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "users/#{@user.id}"
    else
      redirect to "/login"
    end
  end

  # GET: /users/5
  get "/users/:id" do
    if logged_in?
      @user = User.find_by(id: params[:id])
      erb :"/users/show.html"
    else
      redirect to "/login"
    end
  end
  
  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
