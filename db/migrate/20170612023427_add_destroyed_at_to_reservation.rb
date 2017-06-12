class AddDestroyedAtToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :destroyed_at, :datetime
  end
end
