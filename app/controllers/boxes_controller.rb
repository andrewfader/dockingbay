class BoxesController < InheritedResources::Base
  actions :create, :index
  def create
    box_params = permitted_params[:box]
    response = Excon.post("#{BaseResource::API_URL}containers/create",
                          body: %Q{{
                          "Hostname": "#{box_params[:name]}",
                          "Image": "base",
                          "Cmd":["/bin/bash"],
                          "Tty": true,
                          "AttachStdin": true,
                          "OpenStdin": true,
                          "PortSpecs":["3306","22","4443"]
                          }})
    container_id = JSON.parse(response.body)["Id"]
    Excon.post("#{BaseResource::API_URL}containers/#{container_id}/start")
    box_params.merge!(container_id: container_id)
    Box.create!(box_params)
    redirect_to '/'
  end

  def permitted_params
    params.permit(box: [:user_id, :name])
  end
end
