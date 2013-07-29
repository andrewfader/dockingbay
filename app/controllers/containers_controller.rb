class ContainersController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :index, :show
  def show
    @container = Container.find(params[:id])
    unless @container.data.data.present?
      Resque.enqueue(StreamContainerDataJob, {container_id: @container.id, container_data_id: @container.data.id})
    end
    @output = @container.data.data
  end

  def refresh
    @container = Container.find(params[:container_id])
    Resque.enqueue(StreamContainerDataJob, {container_id: @container.id, container_data_id: @container.data.id})
    redirect_to container_path(@container)
  end
end
