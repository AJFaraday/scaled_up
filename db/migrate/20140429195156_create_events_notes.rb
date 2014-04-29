class CreateEventNotes < ActiveRecord::Migration
  def change
    create_table :events_notes, id: false do |t|
      t.belongs_to :events
      t.belongs_to :notes
    end
  end
end
