class ReservationsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@item = Item.find(params[:item_id])
		@reservations = @item.reservations.by_checkout
	end

	def create
		item = Item.find(params[:item_id])
		property = Property.find(params[:property_id])
		@reservation = Reservation.create(
			item_id: item.id,
			property_id: property.id,
		)
		if @reservation.save
			track_activity @reservation
			flash[:notice] = "Reserved #{item.name}"
		else
			flash[:alert] = @reservation.errors.full_messages.first
		end
		redirect_to assign_property_path(property)
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		if @reservation.update_attributes(destroyed_at: DateTime.now)
			track_activity @reservation
			flash[:notice] = "Deleted reservation for #{@reservation.item.name}"
		else
			flash[:alert] = @reservation.errors.full_messages.first
		end
		redirect_to assign_property_path(@reservation.property)
	end

	def manage_checkin
	end

	def manage_checkout
	end

	def checkin
		@item = Item.find_by_id(params[:item][:item_id])
		if !@item
			flash[:alert] = "Can't find item ##{params[:item][:item_id]}"
		elsif @item.reserved_for_property(DateTime.now, DateTime.now)
			property = @item.reserved_for_property(DateTime.now, DateTime.now)
			@reservation = @item.item_reservation(property)
			if @reservation.update_attributes(checkin: DateTime.now)
				track_activity(@reservation, action="checkin")
				flash[:notice] = "Checked in #{@item.name} for #{property.address}, #{property.city}, #{property.state}"
			else
				flash[:alert] = @reservation.errors.full_messages.first
			end
		else
			flash[:alert] = "Can't checkin #{@item.name}"
		end
		redirect_to manage_checkin_reservations_path
	end

	def checkout
		@item = Item.find_by_id(params[:item][:item_id])
		if !@item
			flash[:alert] = "Can't find item ##{params[:item][:item_id]}"
		elsif @item.reserved_for_property(DateTime.now, DateTime.now)
			property = @item.reserved_for_property(DateTime.now, DateTime.now)
			@reservation = @item.item_reservation(property)
			if @reservation.update_attributes(checkout: DateTime.now)
				track_activity(@reservation, action="checkout")
				flash[:notice] = "Checked out #{@item.name} for #{property.address}, #{property.city}, #{property.state}"
			else
				flash[:alert] = reservation.errors.full_messages.first
			end
		else
			flash[:alert] = "Can't checkout #{@item.name}"
		end
		redirect_to manage_checkout_reservations_path
	end
end
