class Container < BaseResource
  def api_object
    @container = Docker::Container.all.first do |container|
      container.id == self.id
    end
  end

  def data
    @data = ContainerData.where(container_id: self.id).first
    @data ||= ContainerData.create(container_id: self.id)
    @data.container_id = self.id
    @data.save!
    @data
  end
end
