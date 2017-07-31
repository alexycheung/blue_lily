class RemoveUnnecessaryFieldsFromItems < ActiveRecord::Migration[5.0]
  def change
  	remove_column :items, :condition, :string
  	remove_column :items, :purchase_price, :decimal
  	remove_column :items, :sale_price, :decimal
  end
end
