class AddUnitIdToReservations < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :unit_id, :integer
  end
end
