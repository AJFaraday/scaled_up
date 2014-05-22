class AddBitsToScale < ActiveRecord::Migration
  def change
    add_column :scales, :bits, :integer
  end
end
