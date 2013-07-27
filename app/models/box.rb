class Box < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  belongs_to :user

  def container
    Container.find(container_id)
  end

  def ports
    JSON.pretty_generate(container.networksettings.PortMapping.Tcp.attributes).to_s.gsub(/[\"\{\}]/,"").gsub(":"," <- ").gsub(",",", ") if container.try(:networksettings).try(:PortMapping)
  end

  def status
    if container.state.Running
      "Up for #{time_ago_in_words(container.state.StartedAt)}"
    else
      "Down (exit #{container.state.ExitCode})"
    end
  end
end
