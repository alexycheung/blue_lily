class CategoriesController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@categories = Category.active.by_date
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			track_activity @category
			flash[:notice] = "Created category #{@category.name}"
			redirect_to categories_path
		else
			flash.now[:alert] = @category.errors.full_messages.first
			render action: "new"
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_params)
			track_activity @category
			flash[:notice] = "Updated category #{@category.name}"
			redirect_to categories_path
		else
			flash.now[:alert] = @category.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@category = Category.find(params[:id])
		if @category.items.active.any?
			flash[:alert] = "Can't delete category that has items"
		elsif @category.update_attributes(destroyed_at: DateTime.now)
			track_activity @category
			flash[:notice] = "Deleted category #{@category.name}"
		else
			flash.now[:alert] = @category.errors.full_messages.first
		end
		redirect_to categories_path
	end

	private

		def category_params
			params.require(:category).permit(:name)
		end
end