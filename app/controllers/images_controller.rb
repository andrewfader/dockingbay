class ImagesController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :index
end
