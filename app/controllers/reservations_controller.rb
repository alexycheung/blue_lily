class ReservationsController < ApplicationController
	def index
		@item = Item.find(params[:id])
		@reservations = @item.reservations.by_checkout
	end
end
