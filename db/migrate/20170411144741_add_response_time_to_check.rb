class AddResponseTimeToCheck < ActiveRecord::Migration[5.0]
  def change
    add_column :checks, :time, :decimal
  end
end
