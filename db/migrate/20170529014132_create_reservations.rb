class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
    	t.belongs_to :item, index: true
    	t.belongs_to :property, index: true
    	t.date :reserved_at
    	t.date :checkin
    	t.date :checkout
      t.timestamps
    end
  end
end
