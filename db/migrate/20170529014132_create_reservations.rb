class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
    	t.belongs_to :item, index: true
    	t.belongs_to :property, index: true
    	t.date :reserved_at
    	t.date :check_in
    	t.date :check_out
      t.timestamps
    end
  end
end
