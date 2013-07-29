class AddFieldsToBoxes < ActiveRecord::Migration
  def change
    change_table :boxes do |t|
      t.string :ref
      t.string :image
      t.string :ports
      t.string :command
    end
  end
end
