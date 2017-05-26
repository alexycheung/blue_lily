class PropertiesController < ApplicationController
	before_action :authenticate_user!

	def new
		@property = Property.new
		@agents = User.agents
	end

	def create
		@property = Property.new(property_params)
		if @property.save
			flash[:notice] = "Created property"
			redirect_to properties_path
		else
			flash.now[:alert] = @property.errors.full_messages.first
			render "new"
		end
	end

	def edit
		@property = Property.find(params[:id])
		@agents = User.agents
	end

	def update
		@property = Property.find(params[:id])
		if @property.update_attributes(property_params)
			flash[:notice] = "Updated property"
			redirect_to properties_path
		else
			flash.now[:alert] = @property.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@property = Property.find(params[:id])
		if @property.destroy
			flash[:notice] = "Deleted property"
		else
			flash[:alert] = @property.errors.full_messages.first
		end
		redirect_to properties_path
	end

	def index
		@properties = Property.by_start_date
	end

	private

		def property_params
			params.require(:property).permit(:zillow_url, :address, :city, :state, :zip, :start_date, :end_date, :bedrooms, :bathrooms, :sqft, :price, :deposit, :user_id)
		end
end