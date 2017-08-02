class AddDimensionsToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :dimensions, :string
  end
end
