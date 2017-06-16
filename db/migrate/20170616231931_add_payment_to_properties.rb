class AddPaymentToProperties < ActiveRecord::Migration[5.0]
  def change
  	add_column :properties, :payment, :string
  end
end
