class AddBasicAuthToSite < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :basic_auth_username, :string, default: nil
    add_column :sites, :basic_auth_password, :string, default: nil
  end
end
