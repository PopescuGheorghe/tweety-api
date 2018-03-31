class CreateStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :statistics do |t|
      t.references :topic, foreign_key: true
      t.string :since_id
      t.datetime :done_at
      t.timestamps
    end
  end
end
