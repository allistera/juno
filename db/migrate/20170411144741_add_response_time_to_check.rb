class AddResponseTimeToCheck < ActiveRecord::Migration[5.0]
  def change
    add_column :checks, :time, :string
  end
end
