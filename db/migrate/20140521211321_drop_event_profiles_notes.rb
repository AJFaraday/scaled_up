class DropEventProfilesNotes < ActiveRecord::Migration
  def change
    drop_table :event_profiles_notes
  end
end
