class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
    	t.string :name
      t.string :photo
    	t.string :size
    	t.string :condition
    	t.decimal :purchase_price
    	t.decimal :sale_price
    	t.text :description
    	t.string :company
    	t.string :color
    	t.integer :category_id
      t.timestamps
    end
  end
end
