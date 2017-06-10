class AddDestroyedAtToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :destroyed_at, :datetime
  end
end
