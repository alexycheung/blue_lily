class PropertiesController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@properties = []
		@cities = []
		@states = []
		@agents = []
		@statuses = []

		Property.active.by_start_date.each do |property|
			if [nil, property.city].include?(params[:city]) &&
				 [nil, property.state].include?(params[:state]) &&
				 [nil, property.user ? property.user.name : nil].include?(params[:agent]) &&
				 [nil, property.status].include?(params[:status])
				@properties << property
			end
			@cities << property.city
			@states << property.state
			@agents << property.user.name if property.user
			@statuses << property.status if property.status
		end

		@cities = @cities.uniq
		@states = @states.uniq
		@agents = @agents.uniq
		@statuses = @statuses.uniq
	end

	def new
		@property = Property.new
	end

	def create
		@property = Property.new(property_params)
		if @property.save
			track_activity @property
			flash[:notice] = "Created property #{@property.address}, #{@property.city}, #{@property.state}, #{@property.zip}"
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
			track_activity @property
			flash[:notice] = "Updated property #{@property.address}, #{@property.city}, #{@property.state}, #{@property.zip}"
			redirect_to properties_path
		else
			flash.now[:alert] = @property.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@property = Property.find(params[:id])
		if @property.update_attributes(destroyed_at: DateTime.now)
			track_activity @property
			flash[:notice] = "Deleted property #{@property.address}, #{@property.city}, #{@property.state}, #{@property.zip}"
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

		Item.active.each do |item|
			if item.reservations.where(property_id: @property.id).any? || !item.reserved_for_property(@property.start_date, @property.end_date)
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
				track_activity @property
				flash[:notice] = "Retrieved property #{@property.address}, #{@property.city}, #{@property.state}, #{@property.zip}"
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

	def barcodes
		@property = Property.find(params[:id])
		@items = @property.items.active
	end

	private

		def property_params
			params.require(:property).permit(:zillow_url, :address, :city, :state, :zip, :start_date, :end_date, :bedrooms, :bathrooms, :sqft, :price, :deposit, :user_id, :payment, :contract)
		end
end