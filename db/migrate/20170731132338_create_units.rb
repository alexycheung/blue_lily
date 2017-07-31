class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
    	t.integer :item_id, null: false
    	t.string :condition, null: false
    	t.decimal :purchase_price, null: false
    	t.decimal :sale_price
    	t.datetime :destroyed_at
      t.timestamps
    end

    add_index :units, :item_id
  end
end
