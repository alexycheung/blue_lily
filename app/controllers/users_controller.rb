class UsersController < ApplicationController
	before_action :authenticate_user!

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Created user"
			redirect_to users_path
		else
			flash.now[:alert] = @user.errors.full_messages.first
			render "new"
		end
	end

	def index
		@users = User.active.by_date
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:notice] = "Updated user"
			redirect_to users_path
		else
			flash.now[:alert] = @user.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user.update_attributes(destroyed_at: DateTime.now)
			flash[:notice] = "Deleted user"
		else
			flash.now[:alert] = @user.errors.full_messages.first
		end
		redirect_to users_path
	end

	private

		def user_params
			params.require(:user).permit(:name, :phone, :company, :email, :role, :password)
		end
end
