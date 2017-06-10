class ItemsController < ApplicationController
	def index
		@items = []
		@colors = []
		@conditions = []
		@categories = []
		@sizes = []

		Item.active.by_date.each do |item|
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

		@colors = @colors.uniq
		@conditions = @conditions.uniq
		@categories = @categories.uniq
		@sizes = @sizes.uniq
	end

	def new
		@item = Item.new
		@categories = Category.by_date
	end

	def create
		@item = Item.new(item_params)
		if @item.save
			flash[:notice] = "Created item"
			redirect_to items_path
		else
			flash.now[:alert] = @item.errors.full_messages.first
			render "new"
		end
	end

	def edit
		@item = Item.find(params[:id])
		@categories = Category.by_date
	end

	def update
		@item = Item.find(params[:id])
		if @item.update_attributes(item_params)
			flash[:notice] = "Updated item"
			redirect_to items_path
		else
			flash.now[:alert] = @item.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@item = Item.find(params[:id])
		if @item.update_attributes(destroyed_at: DateTime.now)
			flash[:notice] = "Deleted item"
		else
			flash.now[:alert] = @item.errors.full_messages.first
		end
		redirect_to items_path
	end

	def zoom
		@item = Item.find(params[:id])
		respond_to do |format|
			format.js
		end
	end

	def cancel_reservation
		@item = Item.find(params[:id])
		@property = Property.find(params[:property_id])
		if Reservation.where(item_id: @item.id, property_id: @property.id).any?
			Reservation.where(item_id: @item.id, property_id: @property.id).first.destroy
			@item.reload
		end
		respond_to do |format|
			format.js
		end
	end

	def reserve
		@item = Item.find(params[:id])
		@property = Property.find(params[:property_id])
		Reservation.create(
			reserved_at: Date.today,
			item_id: @item.id,
			property_id: @property.id,
		)
		@item.reload
		respond_to do |format|
			format.js
		end
	end

	def manage_checkin
	end

	def manage_checkout
	end

	def checkin
		@item = Item.find_by_id(params[:item][:id])
		if !@item
			flash[:alert] = "Can't find item ##{params[:item][:id]}"
		elsif @item.reserved_for_property(DateTime.now, DateTime.now)
			property = @item.reserved_for_property(DateTime.now, DateTime.now)
			reservation = @item.item_reservation(property)
			if reservation.update_attributes(checkin: DateTime.now)
				flash[:notice] = "Checked in #{@item.name} for #{property.address}, #{property.city}, #{property.state}"
			else
				flash[:alert] = reservation.errors.full_messages.first
			end
		else
			flash[:alert] = "Can't checkin #{@item.name}"
		end
		redirect_to manage_checkin_items_path
	end

	def checkout
		@item = Item.find_by_id(params[:item][:id])
		if !@item
			flash[:alert] = "Can't find item ##{params[:item][:id]}"
		elsif @item.reserved_for_property(DateTime.now, DateTime.now)
			property = @item.reserved_for_property(DateTime.now, DateTime.now)
			reservation = @item.item_reservation(property)
			if reservation.update_attributes(checkout: DateTime.now)
				flash[:notice] = "Checked out #{@item.name} for #{property.address}, #{property.city}, #{property.state}"
			else
				flash[:alert] = reservation.errors.full_messages.first
			end
		else
			flash[:alert] = "Can't checkout #{@item.name}"
		end
		redirect_to manage_checkout_items_path
	end

	private

		def item_params
			params.require(:item).permit(:name, :photo, :size, :condition, :purchase_price, :sale_price, :description, :company, :color, :category_id)
		end
end
