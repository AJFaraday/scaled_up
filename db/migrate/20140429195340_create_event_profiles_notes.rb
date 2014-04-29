class CreateEventProfilesNotes < ActiveRecord::Migration
  def change
    create_table :event_profiles_notes do |t|
      t.belongs_to :event_profile
      t.belongs_to :note
    end
  end
end
