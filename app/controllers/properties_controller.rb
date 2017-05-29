class PropertiesController < ApplicationController
	before_action :authenticate_user!

	def index
		@properties = Property.by_start_date
	end

	def new
		@property = Property.new
	end

	def create
		@property = Property.new(property_params)
		if @property.save
			flash[:notice] = "Created property"
			redirect_to properties_path
		else
			flash.now[:alert] = @property.errors.full_messages.first
			render action: "new"
		end
	end

	def edit
		@property = Property.find(params[:id])
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

	def assign
		@property = Property.find(params[:id])
		@items = []
		Item.all.each do |item|
			if item.reservations.where(property_id: @property.id).any? || !item.reserved?(@property.start_date, @property.end_date)
				@items << item
			end
		end
	end

	private

		def property_params
			params.require(:property).permit(:zillow_url, :address, :city, :state, :zip, :start_date, :end_date, :bedrooms, :bathrooms, :sqft, :price, :deposit, :user_id)
		end
end