class ItemsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@items = []
		@colors = []
		@categories = []
		@vendors = []
		@sizes = []

		if params[:query] && !params[:query].empty?
			items = Item.active.search(params[:query], fields: [:name, :vendor_item_number])
		else
			items = Item.active.by_date
		end

		items.each do |item|
			if [nil, item.color].include?(params[:color]) &&
				 [nil, item.category.name].include?(params[:category]) &&
				 [nil, item.size].include?(params[:size]) &&
				 [nil, item.vendor.name].include?(params[:vendor])
				@items << item
			end
			@colors << item.color
			@categories << item.category.name
			@vendors << item.vendor.name
			@sizes << item.size
		end

		@colors = @colors.uniq
		@categories = @categories.uniq
		@vendors = @vendors.uniq
		@sizes = @sizes.uniq
	end

	def new
		@item = Item.new
		@categories = Category.active.by_date
	end

	def create
		@item = Item.new(item_params)
		if @item.save
			flash[:notice] = "Created item #{@item.name}"
			redirect_to items_path
		else
			flash.now[:alert] = @item.errors.full_messages.first
			render "new"
		end
	end

	def edit
		@item = Item.find(params[:id])
		@categories = Category.active.by_date
	end

	def update
		@item = Item.find(params[:id])
		if @item.update_attributes(item_params)
			flash[:notice] = "Updated item #{@item.name}"
			redirect_to items_path
		else
			flash.now[:alert] = @item.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@item = Item.find(params[:id])
		if @item.update_attributes(destroyed_at: DateTime.now)
			flash[:notice] = "Deleted item #{@item.name}"
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

	private

		def item_params
			params.require(:item).permit(
				:vendor_id, 
				:name, 
				:photo, 
				:size, 
				:description, 
				:color, 
				:category_id,
				:dimensions,
				:vendor_item_number,
			)
		end
end
