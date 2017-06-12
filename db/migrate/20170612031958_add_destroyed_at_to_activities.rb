class AddDestroyedAtToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :destroyed_at, :datetime
  end
end
