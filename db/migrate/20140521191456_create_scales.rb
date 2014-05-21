class CreateScales < ActiveRecord::Migration
  def change
    create_table :scales do |t|
      t.string :name
      t.boolean :current
      t.boolean :a
      t.boolean :a_sharp
      t.boolean :b
      t.boolean :c
      t.boolean :c_sharp
      t.boolean :d
      t.boolean :d_sharp
      t.boolean :e
      t.boolean :f
      t.boolean :f_sharp
      t.boolean :g
      t.boolean :g_sharp

      t.timestamps
    end
  end
end
