class UnitsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@unit = Unit.new
		@item = Item.find(params[:item_id])
		@units = @item.units.active.by_date
	end

	def create
		@item = Item.find(params[:item_id])
		@unit = @item.units.build(item_params)
		if @unit.save
			flash[:notice] = "Created unit for #{@item.name}"
			redirect_to edit_item_units_path(@item, @unit)
		else
			flash[:alert] = @unit.errors.full_messages.first
			redirect_to item_units_path(@item)
		end
	end

	def edit
		@item = Item.find(params[:item_id])
		@unit = Unit.find(params[:id])
	end

	def update
		@item = Item.find(params[:item_id])
		@unit = Unit.find(params[:id])
		if @unit.update_attributes(unit_params)
			flash[:notice] = "Updated unit for #{@item.name}"
			redirect_to edit_item_units_path(@item, @unit)
		else
			flash.now[:alert] = @unit.errors.full_messages_first
			render "edit"
		end
	end

	def destroy
		@item = Item.find(params[:item_id])
		@unit = Unit.find(params[:id])
		if @unit.update_attributes(destroyed: DateTime.now)
			flash[:notice] = "Deleted unit for #{@item.name}"
		else
			flash.now[:alert] = @unit.errors.full_messages.first
		end
		redirect_to item_units_path(@item)
	end

	private

		def unit_params
			params.require(:unit).permit(:item_id, :condition, :purchase_price, :sale_price, :destroyed_at)
		end
end
