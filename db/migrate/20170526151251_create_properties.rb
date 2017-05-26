class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
			t.string  :zillow_url
			t.string  :address
			t.string  :city
			t.string  :state
			t.string  :zip
			t.date    :start_date
			t.date    :end_date
			t.integer :bedrooms
			t.integer :bathrooms
			t.integer :sqft
			t.decimal :price
			t.decimal :deposit
			t.string  :user_id
      t.timestamps
    end
  end
end
