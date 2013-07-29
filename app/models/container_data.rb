class ContainerData < ActiveRecord::Base
  include Ansible
  belongs_to :container

  def get_data
    @output = nil
    self.data = nil
    self.save!
    streamer = proc do |chunk, remaining_bytes, total_bytes|
      @output = (@output || "") + ansi_escaped(chunk)
      self.data = (self.data || "") + ansi_escaped(chunk)
      self.save!
    end

    @output ||= Excon.post("#{BaseResource::API_URL}containers/#{container_id}/attach?logs=1&stream=0&stdout=1", response_block: streamer)

  end
end
