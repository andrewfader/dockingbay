class IndexContainerDataOnContainerId < ActiveRecord::Migration
  def change
    add_index :boxes, :user_id
    add_index :container_data, :container_id
  end
end
