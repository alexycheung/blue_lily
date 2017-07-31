class AddVendorItemNumberToItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :items, :vendor_item_number, :string
  end
end
