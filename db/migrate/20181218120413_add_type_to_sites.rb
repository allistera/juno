class AddTypeToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :site_type, :string
  end
end
