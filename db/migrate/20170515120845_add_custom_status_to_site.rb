class AddCustomStatusToSite < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :custom_status, :integer, default: nil
  end
end
