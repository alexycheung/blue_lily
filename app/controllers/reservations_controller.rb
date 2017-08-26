class ReservationsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@unit = Unit.find(params[:unit_id])
		@reservations = @unit.reservations.active.by_checkout
	end

	def create
		unit = Unit.find(params[:unit_id])
		property = Property.find(params[:property_id])
		@reservation = Reservation.new(
			unit_id: unit.id,
			property_id: property.id,
		)
		if @reservation.save
			flash[:notice] = "Reserved #{unit.item.name}"
		else
			flash[:alert] = @reservation.errors.full_messages.first
		end
		redirect_to assign_property_path(property)
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		if @reservation.update_attributes(destroyed_at: DateTime.now)
			flash[:notice] = "Deleted reservation for #{@reservation.unit.item.name}"
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
		@unit = Unit.find_by_id(params[:unit][:unit_id])
		if !@unit
			flash[:alert] = "Can't find unit ##{params[:unit][:unit_id]}"
		elsif @unit.reserved_for_property(DateTime.now, DateTime.now)
			property = @unit.reserved_for_property(DateTime.now, DateTime.now)
			@reservation = @unit.unit_reservation(property)
			if @reservation.update_attributes(checkin: DateTime.now)
				flash[:notice] = "Checked in #{@unit.item.name} for #{property.address}, #{property.city}, #{property.state}"
			else
				flash[:alert] = @reservation.errors.full_messages.first
			end
		else
			flash[:alert] = "Can't checkin #{@unit.item.name}"
		end
		redirect_to manage_checkin_reservations_path
	end

	def checkout
		@unit = Unit.find_by_id(params[:unit][:unit_id])
		if !@unit
			flash[:alert] = "Can't find unit ##{params[:unit][:unit_id]}"
		elsif @unit.reserved_for_property(DateTime.now, DateTime.now)
			property = @unit.reserved_for_property(DateTime.now, DateTime.now)
			@reservation = @unit.unit_reservation(property)
			if @reservation.update_attributes(checkout: DateTime.now)
				flash[:notice] = "Checked out #{@unit.item.name} for #{property.address}, #{property.city}, #{property.state}"
			else
				flash[:alert] = reservation.errors.full_messages.first
			end
		else
			flash[:alert] = "Can't checkout #{@unit.item.name}"
		end
		redirect_to manage_checkout_reservations_path
	end
end
