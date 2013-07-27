class Box < ActiveRecord::Base
  belongs_to :user

  def container
    Container.find(container_id)
  end

  def ports
    JSON.pretty_generate(container.networksettings.PortMapping.Tcp.attributes).to_s.gsub(/[\"\{\}]/,"").gsub(":"," <- ").gsub(",",", ") if container.try(:networksettings).try(:PortMapping)
  end
end
