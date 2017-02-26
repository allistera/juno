class CreateChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :checks do |t|
      t.integer :status
      t.references :site, foreign_key: true

      t.timestamps
    end
  end
end
