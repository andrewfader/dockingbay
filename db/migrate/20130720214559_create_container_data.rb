class CreateContainerData < ActiveRecord::Migration
  def change
    create_table :container_data do |t|
      t.text :data
      t.binary :blob
      t.string :container_id
      t.timestamps
    end
  end
end
