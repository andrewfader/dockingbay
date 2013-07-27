class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.timestamps
      t.string :container_id
      t.integer :user_id
      t.string :name
    end
  end
end
