class ChangeTimeToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :checks, :time, 'decimal USING CAST(time AS decimal)'
  end
end
