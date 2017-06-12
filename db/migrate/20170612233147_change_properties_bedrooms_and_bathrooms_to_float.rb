class ChangePropertiesBedroomsAndBathroomsToFloat < ActiveRecord::Migration[5.0]
  def change
  	change_column :properties, :bedrooms, :float
  	change_column :properties, :bathrooms, :float
  end
end
