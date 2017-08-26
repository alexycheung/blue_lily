class PropertiesController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@properties = []
		@cities = []
		@states = []
		@agents = []

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
		end

		@cities = @cities.uniq
		@states = @states.uniq
		@agents = @agents.uniq
		@statuses = ["pending", "open", "closed"]
	end

	def new
		@property = Property.new
	end

	def create
		@property = Property.new(property_params)
		if @property.save
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
			flash[:notice] = "Deleted property #{@property.address}, #{@property.city}, #{@property.state}, #{@property.zip}"
		else
			flash.now[:alert] = @property.errors.full_messages.first
		end
		redirect_to properties_path
	end

	def assign
		@property = Property.find(params[:id])
		@units = []
		@colors = []
		@conditions = []
		@categories = []
		@sizes = []
		@vendors = []

		if params[:query] && !params[:query].empty?
			items = Item.active.search(params[:query], fields: [:name, :vendor_item_number])
		else
			items = Item.active.by_date
		end

		items.each do |item|
			item.units.active.each do |unit|
				if unit.reservations.active.where(property_id: @property.id).any? || !unit.reserved_for_property(@property.start_date, @property.end_date)
					if [nil, unit.condition].include?(params[:condition]) &&
						 [nil, item.color].include?(params[:color]) &&
						 [nil, item.category.name].include?(params[:category]) &&
						 [nil, item.size].include?(params[:size]) &&
						 [nil, item.vendor.name].include?(params[:vendor])
						@units << unit
					end
				end
				@conditions << unit.condition
				@colors << item.color
				@categories << item.category.name
				@sizes << item.size
				@vendors << item.vendor.name
			end
		end

		@colors = @colors.uniq
		@conditions = @conditions.uniq
		@categories = @categories.uniq
		@sizes = @sizes.uniq
		@vendors = @vendors.uniq
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
	end

	def quick_checkout
		@property = Property.find(params[:id])
		if !params[:unit_id] || params[:unit_id] == ""
			# check if unit id is valid
			flash.now[:alert] = "Please enter a valid unit ID"
		elsif !Unit.find_by_id(params[:unit_id])
			# check if unit is valid
			flash.now[:alert] = "There is no unit with ID ##{params[:unit_id]}"
		elsif @unit = Unit.find_by_id(params[:unit_id])
			if @unit.destroyed_at
				flash.now[:alert] = "Unit ##{@unit.id} was deleted"
			elsif @unit.reservations.active.where(property_id: @property.id).any? || !@unit.reserved_for_property(@property.start_date, @property.end_date)
				# reserve and checkout unit for property
				if Reservation.where(unit_id: @unit.id, property_id: @property.id).any?
					@reservation = Reservation.where(unit_id: @unit.id, property_id: @property.id).first
					@reservation.update_attributes(created_at: DateTime.now, checkout: Date.today)
				else
					@reservation = Reservation.new(
						unit_id: @unit.id,
						property_id: @property.id,
						checkout: Date.today,
					)
					@reservation.save
				end
				flash.now[:notice] = "Reserved and checked out unit ##{@unit.id}"
			else
				flash.now[:alert] = "Unit ##{params[:unit_id]} is not available for this property's dates"
			end
		end
		respond_to do |format|
			format.js
		end
	end

	private

		def property_params
			params.require(:property).permit(:zillow_url, :address, :city, :state, :zip, :start_date, :end_date, :bedrooms, :bathrooms, :sqft, :price, :deposit, :user_id, :payment, :contract)
		end
end
