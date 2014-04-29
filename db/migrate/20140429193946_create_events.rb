class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :source
      t.integer :length
      t.integer :sample_id
      t.boolean :played

      t.timestamps
    end
  end
end
