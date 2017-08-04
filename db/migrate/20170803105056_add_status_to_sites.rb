class AddStatusToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :status, :string
  end
end
