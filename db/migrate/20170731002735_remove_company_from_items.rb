class RemoveCompanyFromItems < ActiveRecord::Migration[5.0]
  def change
  	remove_column :items, :company, :string
  end
end
