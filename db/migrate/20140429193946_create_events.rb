class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :source
      t.integer :steps
      t.integer :sample_id
      t.integer :event_profile_id
      t.integer :length_id

      t.timestamps
    end
  end
end
