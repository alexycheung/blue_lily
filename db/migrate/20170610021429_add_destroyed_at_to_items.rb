class AddDestroyedAtToItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :items, :destroyed_at, :datetime
  end
end
