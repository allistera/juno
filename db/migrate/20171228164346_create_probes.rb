class CreateProbes < ActiveRecord::Migration[5.1]
  def change
    create_table :probes do |t|
      t.string :name
      t.string :url
      t.timestamps
    end
  end
end
