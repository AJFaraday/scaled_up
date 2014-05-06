class AddLastPlayedEventMessageIdToEventProfiles < ActiveRecord::Migration
  def change
    add_column :event_profiles, :last_played_message_id, :integer
  end
end
