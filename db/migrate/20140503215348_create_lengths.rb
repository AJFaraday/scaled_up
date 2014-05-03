class CreateLengths < ActiveRecord::Migration
  def change
    create_table :lengths do |t|
      t.string :name
      t.integer :steps
      t.string :image

      t.timestamps
    end
  end
end
