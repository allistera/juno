class CreateSlackSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_settings do |t|
      t.string :webhook_url
      t.string :channel
      t.string :username
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
