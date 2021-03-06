class BoxesController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :create, :index
  def create
    box_params = permitted_params[:box]
    response = Excon.post("#{BaseResource::API_URL}containers/create",
                          body: %Q{{
                          "Hostname": "#{box_params[:name]}",
                          "Image": "#{box_params[:image]}",
                          "Cmd":["#{box_params[:command]}"],
                          "Tty": true,
                          "AttachStdin": true,
                          "OpenStdin": true,
                          "PortSpecs":["3306","22","4443"]
                          }})
    container_id = JSON.parse(response.body)["Id"]
    Excon.post("#{BaseResource::API_URL}containers/#{container_id}/start")
    box_params.merge!(container_id: container_id)
    box = Box.new(box_params)
    if box.save
      flash[:notice] = "#{Box.last.name} is in the docking bay."
    else
      flash[:alert] = "Error provisioning new box: #{box.errors.messages.flatten.join(": ")}"
    end
    redirect_to '/'
  end

  def permitted_params
    params.permit(box: [:user_id, :name, :ref, :image, :command])
  end
end
