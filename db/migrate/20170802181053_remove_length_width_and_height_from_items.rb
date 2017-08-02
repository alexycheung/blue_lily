class RemoveLengthWidthAndHeightFromItems < ActiveRecord::Migration[5.0]
  def change
  	remove_column :items, :length, :decimal
  	remove_column :items, :width, :decimal
  	remove_column :items, :height, :decimal
  end
end
