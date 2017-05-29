class ItemsController < ApplicationController
	def index
		@items = Item.by_date
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
		if @item.destroy
			flash[:notice] = "Deleted item"
		else
			flash[:alert] = @item.errors.full_messages.first
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

	def checkout
		@item = Item.find(params[:id])
		@property = Property.find(params[:property_id])
		reservation = Reservation.where(item_id: @item.id, property_id: @property.id).first
		reservation.checkout = Date.today
		reservation.save
		respond_to do |format|
			format.js
		end
	end

	def reverse_checkout
		@item = Item.find(params[:id])
		@property = Property.find(params[:property_id])
		reservation = Reservation.where(item_id: @item.id, property_id: @property.id).first
		reservation.checkout = nil
		reservation.save
		respond_to do |format|
			format.js
		end
	end

	def checkin
		@item = Item.find(params[:id])
		@property = Property.find(params[:property_id])
		reservation = Reservation.where(item_id: @item.id, property_id: @property.id).first
		reservation.checkin = Date.today
		reservation.save
		respond_to do |format|
			format.js
		end
	end

	def reverse_checkin
		@item = Item.find(params[:id])
		@property = Property.find(params[:property_id])
		reservation = Reservation.where(item_id: @item.id, property_id: @property.id).first
		reservation.checkin = nil
		reservation.save
		respond_to do |format|
			format.js
		end
	end

	private

		def item_params
			params.require(:item).permit(:name, :photo, :size, :condition, :purchase_price, :sale_price, :description, :company, :color, :category_id)
		end
end
