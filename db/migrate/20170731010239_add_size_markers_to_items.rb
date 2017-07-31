class AddSizeMarkersToItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :items, :height, :decimal
  	add_column :items, :width, :decimal
  	add_column :items, :length, :decimal
  end
end
