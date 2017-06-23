class PhotosController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user

	def create
		@property = Property.find(params[:property_id])
		@photo = @property.photos.build(photo_params)
		if @photo.save
			flash[:notice] = "Created photo for #{@property.address}, #{@property.city}, #{@property.state}"
		else
			flash.now[:alert] = @photo.errors.full_messages.first
		end
		redirect_to property_photos_path(@property)
	end

	def destroy
		@photo = Photo.find(params[:id])
		@property = @photo.property
		if @photo.update_attributes(destroyed_at: DateTime.now)
			flash[:notice] = "Deleted photo for #{@property.address}, #{@property.city}, #{@property.state}"
		else
			flash.now[:alert] = @photo.errors.full_messages.first
		end
		redirect_to property_photos_path(@property)
	end

	def index
		@photo = Photo.new
		@property = Property.find(params[:property_id])
		@photos = @property.photos.active.by_date
	end

	private

		def photo_params
			params.require(:photo).permit(:url, :property_id, :destroyed_at)
		end
end
