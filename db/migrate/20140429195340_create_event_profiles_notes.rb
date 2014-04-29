class CreateEventProfilesNotes < ActiveRecord::Migration
  def change
    create_table :event_profiles_notes do |t|
      t.integer :event_profile_id
      t.integer :note_id
    end
  end
end
