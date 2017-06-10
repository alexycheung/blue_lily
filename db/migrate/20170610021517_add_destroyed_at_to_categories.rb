class AddDestroyedAtToCategories < ActiveRecord::Migration[5.0]
  def change
  	add_column :categories, :destroyed_at, :datetime
  end
end
