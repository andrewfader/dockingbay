class Box < ActiveRecord::Base
  belongs_to :user

  def container
    Container.find(container_id)
  end
end
