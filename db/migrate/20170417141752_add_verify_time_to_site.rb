class AddVerifyTimeToSite < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :verify_ssl, :boolean, default: true
  end
end
