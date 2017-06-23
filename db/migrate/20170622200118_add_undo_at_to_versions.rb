class AddUndoAtToVersions < ActiveRecord::Migration[5.0]
  def change
  	add_column :versions, :undo_at, :datetime
  end
end
