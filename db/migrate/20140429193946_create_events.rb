class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :source
      t.integer :length
      t.integer :sample_id
      t.integer :event_profile_id

      t.timestamps
    end
  end
end
