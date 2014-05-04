class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.string :name
      t.string :display_name
      t.string :description
      t.string :default
      t.string :value
      t.string :value_class
 
    end
  end
end
