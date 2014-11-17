class RestaurantsController < ApplicationController
	before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
	
	def welcome
		@message = "Welcome to Dirty Napkin"
	end

	def index
		@restaurants = Restaurant.all
	end

	def show
		@restaurant = Restaurant.first
	end

	def new
		@restaurant = Restaurant.new
	end

	def edit
		@restaurant = Restaurant.find(params[:id])
	end

	def create
	@restaurant = Restaurant.new(restaurant_params) 
	  if @restaurant.save
	    redirect_to restaurants_path
	  else
		render :new
	  end
	end

	def update
	@restuarant = Restuarant.find(params[:id])
	  if restuarant_attributes(restuarant_params)
	    redirect_to restuarants_path(@restuarant)
	  else
		flash[:notice] = "Error editing profile. Please fill in all fields."
		render :edit
	  end
	end

	def destroy
		@restaurant.destroy
		redirect_to restaurants_path, notice: 'Restaurant removed successfully'
	end

	private
	def set_restaurant
		@restaurant = Restaurant.find(params[:id])
	end

	def restaurant_params
		params.require(:restaurant).permit(:name, :address, :description, :open_hour, :close_hour, :capacity)
	end		
end
