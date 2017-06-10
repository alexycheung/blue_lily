class AddDestroyedAtToProperties < ActiveRecord::Migration[5.0]
  def change
  	add_column :properties, :destroyed_at, :datetime
  end
end
