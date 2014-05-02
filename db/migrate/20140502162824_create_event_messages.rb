class CreateEventMessages < ActiveRecord::Migration
  def change
    create_table :event_messages do |t|
      t.integer :event_id
      t.integer :event_profile_id
      t.string :content
      t.boolean :played

      t.timestamps
    end
  end
end
