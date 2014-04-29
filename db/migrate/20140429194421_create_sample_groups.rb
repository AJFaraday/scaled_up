class CreateSampleGroups < ActiveRecord::Migration
  def change
    create_table :sample_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
