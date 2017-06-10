class CategoriesController < ApplicationController
	before_action :authenticate_user!

	def index
		@categories = Category.active.by_date
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Created category"
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
			flash[:notice] = "Updated category"
			redirect_to categories_path
		else
			flash.now[:alert] = @category.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@category = Category.find(params[:id])
		if @category.items.any?
			flash[:alert] = "Can't delete category that has items"
		elsif @category.update_attributes(destroyed_at: DateTime.now)
			flash[:notice] = "Deleted category"
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