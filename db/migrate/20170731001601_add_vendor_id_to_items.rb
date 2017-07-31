class AddVendorIdToItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :items, :vendor_id, :integer
  end
end
