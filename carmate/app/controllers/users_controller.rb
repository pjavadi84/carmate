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
      flash[:message]="field can't be empty! Please fill out all the information and try again."
      redirect to '/signup'
    else
      if User.find_by(username: params[:username], email: params[:email], first_name: params[:first_name], last_name: params[:last_name])
          flash[:message]="user profile already exist in our database. please try another email."
          redirect to '/signup'
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
      flash[:login_success] = "login successful!"
      redirect to '/cars/show.html'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "users/#{@user.id}"
    else
      flash[:message]="login credential failed. Please try again!"
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
