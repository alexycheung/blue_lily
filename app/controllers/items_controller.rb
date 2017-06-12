class ItemsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

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
		@categories = Category.active.by_date
	end

	def create
		@item = Item.new(item_params)
		if @item.save
			track_activity @item
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
			track_activity @item
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
			track_activity @item
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
			params.require(:item).permit(:name, :photo, :size, :condition, :purchase_price, :sale_price, :description, :company, :color, :category_id)
		end
end
