class AddContractToProperties < ActiveRecord::Migration[5.0]
  def change
  	add_column :properties, :contract, :string
  end
end
