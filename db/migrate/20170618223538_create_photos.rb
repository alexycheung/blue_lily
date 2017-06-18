class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
    	t.string :url
    	t.integer :property_id
    	t.datetime :destroyed_at
      t.timestamps
    end
  end
end
