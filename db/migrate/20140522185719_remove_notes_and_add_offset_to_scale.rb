class RemoveNotesAndAddOffsetToScale < ActiveRecord::Migration
  def change
    remove_column :scales, :c
    remove_column :scales, :c_sharp
    remove_column :scales, :d
    remove_column :scales, :d_sharp
    remove_column :scales, :e
    remove_column :scales, :f
    remove_column :scales, :f_sharp
    remove_column :scales, :g
    remove_column :scales, :g_sharp
    remove_column :scales, :a
    remove_column :scales, :a_sharp
    remove_column :scales, :b
    add_column :scales, :offset, :integer 
  end
end
