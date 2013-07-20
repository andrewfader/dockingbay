class ContainersController < ApplicationController

  def index
    @containers = Container.all
  end

  def show
    @container = Container.find(params[:id])
    Resque.enqueue(StreamContainerDataJob, {container_id: @container.id, container_data_id: @container.data.id})
    @output = @container.data.data
  end
end
