class CustomersController < ApplicationController
	before_action :set_customer, only: [:show, :edit, :update, :destroy]

	def index
		@customers = Customer.all
	end

	def show
		@customer = Customer.find(params[:id])
		if Customer.first
			@reservation = @customer.reservations.all
		end
	end

	def new
		@customer = Customer.new
	end

	def edit
		@customer = Customer.find(params[:id])
	end

	def create
		@customer = Customer.new(customer_params) 
		if @customer.save
			redirect_to root_path
		else
			flash[:notice] = "Please instantiate yourself."
			render :new
		end
	end

	def update
		@customer = Customer.find(params[:id])
		if customer_attributes(customer_params)
			redirect_to customers_path(@customer)
		else
		  flash[:notice] = "Error editing profile. Please fill in all fields."
		  render :edit
	end
	end

	def destroy
		@customer = Customer.find(params[:id])
		@customer.destroy
		redirect_to customers_path
	end

	private

	def set_customer
		@customer = Customer.find(params[:id])	
	end

	def customer_params
		params.require(:customer).permit(:name, :email, :password, :password_confirmation, :type)
	end
end
