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
    erb :"/cars/new.html"
  end

  # POST: /cars
  post "/cars" do
    if logged_in?
      if params[:make] == "" || params[:model] == "" || params[:color] == "" || params[:car_type] == "" || params[:price] == ""
        redirect "/cars/new"
      else
        @car = current_user.cars.new(
          make: params[:make],
          model: params[:model],
          color: params[:color],
          car_type: params[:car_type],
          price: params[:price]
          )
          if @car.save
            redirect to "/cars/#{@car.id}"
          else
            redirect to "/cars/new"
          end
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
    erb :"/cars/edit.html"
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
