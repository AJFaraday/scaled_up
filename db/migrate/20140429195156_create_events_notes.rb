class CreateEventsNotes < ActiveRecord::Migration
  def change
    create_table :events_notes, id: false do |t|
      t.integer :event_id
      t.integer :note_id
    end
  end
end
