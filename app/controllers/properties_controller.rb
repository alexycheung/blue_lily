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
		if @property.schedule_conflict?(
			property_params[:start_date].to_date,
			property_params[:end_date].to_date,
		)
			flash.now[:alert] = "Property dates conflict with item availability"
			render "edit"
		elsif @property.update_attributes(property_params)
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
			flash.now[:alert] = @property.errors.full_messages.first
		end
		redirect_to properties_path
	end

	def assign
		@property = Property.find(params[:id])
		@items = []
		@colors = []
		@conditions = []
		@categories = []
		@sizes = []

		Item.all.each do |item|
			if item.reservations.where(property_id: @property.id).any? || !item.reserved?(@property.start_date, @property.end_date)
				if [nil, item.color].include?(params[:color]) &&
					 [nil, item.condition].include?(params[:condition]) &&
					 [nil, item.category.name].include?(params[:category]) &&
					 [nil, item.size].include?(params[:size])
					@items << item
				end
				@colors << item.color
				@conditions << item.condition
				@categories << item.category.name
				@sizes << item.size
			end
		end

		@colors = @colors.uniq
		@conditions = @conditions.uniq
		@categories = @categories.uniq
		@sizes = @sizes.uniq
	end

	def retrieve
		@property = Property.new(property_params)
		response = ZillowService.get_property(property_params[:zillow_url])
		if response
			@property = Property.new(
				zillow_url: response[:zillow_url],
				address: response[:address],
				city: response[:city],
				state: response[:state],
				zip: response[:zip],
				bedrooms: response[:bedrooms],
				bathrooms: response[:bathrooms],
				sqft: response[:sqft],
			)
			if @property.save
				flash[:notice] = "Retrieved property"
				redirect_to edit_property_path(@property)
			else
				flash.now[:alert] = @property.errors.full_messages.first
				render :zillow
			end
		else
			flash.now[:alert] = "Failed to retrieve property"
			render :zillow
		end
	end

	def zillow
		@property = Property.new
	end

	private

		def property_params
			params.require(:property).permit(:zillow_url, :address, :city, :state, :zip, :start_date, :end_date, :bedrooms, :bathrooms, :sqft, :price, :deposit, :user_id)
		end
end