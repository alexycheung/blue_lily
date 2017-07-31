class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
    	t.string :name, null: false
    	t.datetime :destroyed_at
      t.timestamps
    end
  end
end
