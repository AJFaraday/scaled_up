class CreateEventProfiles < ActiveRecord::Migration
  def change
    create_table :event_profiles do |t|
      t.string :name
      t.integer :no_of_notes
      t.boolean :sample
      t.integer :sample_group_id
      t.integer :min_note
      t.integer :max_note
      t.string :ip_address
      t.integer :port

      t.timestamps
    end
  end
end
