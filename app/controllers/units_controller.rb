class UnitsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@unit = Unit.new
		@item = Item.find(params[:item_id])
		@units = @item.units.active.by_date
	end

	def new
		@item = Item.find(params[:item_id])
		@unit = Unit.new
	end

	def create
		@item = Item.find(params[:item_id])
		quantity = params[:quantity] ? params[:quantity].to_i : 1
		unit_count = 0

		(0...quantity).each do |count|
			@unit = @item.units.build(unit_params)
			unit_count += 1 if @unit.save
		end

		if unit_count == quantity
			flash[:notice] = "Created #{'unit'.pluralize(unit_count)} for #{@item.name}"
			redirect_to item_units_path(@item)
		else
			flash[:alert] = @unit.errors.full_messages.first
			render "new"
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
			redirect_to item_units_path(@item)
		else
			flash.now[:alert] = @unit.errors.full_messages_first
			render "edit"
		end
	end

	def barcode
		@item = Item.find(params[:item_id])
		@unit = Unit.find(params[:id])
	end

	def destroy
		@item = Item.find(params[:item_id])
		@unit = Unit.find(params[:id])
		if @unit.update_attributes(destroyed_at: DateTime.now)
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
