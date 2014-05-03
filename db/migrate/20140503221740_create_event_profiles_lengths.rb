class CreateEventProfilesLengths < ActiveRecord::Migration
  def change
    create_table :event_profiles_lengths do |t|
      t.integer :event_profile_id
      t.integer :length_id
    end
  end
end
