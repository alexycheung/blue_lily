class RemoveReservedAtFromReservations < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reservations, :reserved_at, :date
  end
end
