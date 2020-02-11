class CarsController < ApplicationController

  # GET: /cars
  get "/cars" do
    if logged_in?
      @cars = Car.all
      erb :"/cars/cars.html"
    else
      redirect to '/login'
    end
  end

  # GET: /cars/new
    get "/cars/new" do
    if logged_in?
      erb :"/cars/new.html"
    else
      redirect to '/login'
    end
  end

  # POST: /cars
  post "/cars" do
    if logged_in?
      if params[:make] == "" || params[:model] == "" || params[:color] == "" || params[:car_type] == "" || params[:price] == ""
        redirect "/"
      else
        @car = Car.create(
          make: params[:make],
          model: params[:model],
          color: params[:color],
          car_type: params[:car_type],
          price: params[:price],
          user_id: current_user.id
          )
          
          redirect to "/cars/#{@car.id}"  
        end
      else
      redirect to '/login'
    end
  end

  # GET: /cars/5
  get "/cars/:id" do
    if logged_in?
      @car = Car.find_by_id(params[:id])
      erb :"/cars/show.html"
    else
      redirect to "/login"
    end
  end

  # GET: /cars/5/edit
  get "/cars/:id/edit" do
    if logged_in?
      @user = User.find_by_id(params[:id])
      if @user && @car.user = current_user
        erb :"/cars/edit.html"
      else
        redirect to "/cars"
      end
    else
      redirect to "/login"
    end
  end

  # PATCH: /cars/5
  patch "/cars/:id" do
    redirect "/cars/:id"
  end

  # DELETE: /cars/5/delete
  delete "/cars/:id/delete" do
    redirect "/cars"
  end
end
