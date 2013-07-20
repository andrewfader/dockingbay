class StreamContainerDataJob
  include Ansible
  @queue = :default
  def self.perform(hash)
    puts hash
    @data = ContainerData.find_or_create_by_id(hash["container_data_id"])
    @data.container_id = hash["container_id"]
    @data.save!
    @data.get_data
  end
end
