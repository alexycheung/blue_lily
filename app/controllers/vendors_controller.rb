class VendorsController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def index
		@vendors = Vendor.active.by_name
	end

	def new
		@vendor = Vendor.new
	end

	def create
		@vendor = Vendor.new(vendor_params)
		if @vendor.save
			flash[:notice] = "Created vendor #{@vendor.name}"
			redirect_to vendors_path
		else
			flash.now[:alert] = @vendor.errors.full_messages.first
			render "new"
		end
	end

	def edit
		@vendor = Vendor.find(params[:id])
	end

	def update
		@vendor = Vendor.find(params[:id])
		if @vendor.update_attributes(vendor_params)
			flash[:notice] = "Updated vendor #{@vendor.name}"
			redirect_to vendors_path
		else
			flash.now[:alert] = @vendor.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@vendor = Vendor.find(params[:id])
		if @vendor.update_attributes(destroyed_at: DateTime.now)
			flash[:notice] = "Deleted vendor #{@vendor.name}"
		else
			flash.now[:alert] = @vendor.errors.full_messages.first
		end
		redirect_to vendors_path
	end

	private

		def vendor_params
			params.require(:vendor).permit(:name)
		end
end
