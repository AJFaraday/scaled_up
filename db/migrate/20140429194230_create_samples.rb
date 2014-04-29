class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :name
      t.integer :sample_group_id
      t.string :display_name

      t.timestamps
    end
  end
end
