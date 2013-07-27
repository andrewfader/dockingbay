class ContainersController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :index, :show
  def show
    @container = Container.find(params[:id])
    Resque.enqueue(StreamContainerDataJob, {container_id: @container.id, container_data_id: @container.data.id})
    @output = @container.data.data
  end
end
