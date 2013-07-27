class ContainerData < ActiveRecord::Base
  include Ansible
  belongs_to :container

  def get_data
    @output = ""
    streamer = proc do |chunk, remaining_bytes, total_bytes|
      @output = (@output || "") + ansi_escaped(chunk)
      self.data = (self.data || "") + ansi_escaped(chunk)
      self.save!
      return if @output.length > 209715
    end

    Excon.post("#{BaseResource::API_URL}containers/#{container_id}/attach?logs=1&stream=1&stdout=1", response_block: streamer)

  end
end
