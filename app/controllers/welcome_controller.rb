class WelcomeController < ApplicationController
  def index
    @images = Image.recent
    @containers = Container.recent
  end
end
