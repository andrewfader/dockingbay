class WelcomeController < ApplicationController
  def index
    @images = Image.all
    @containers = Container.all
  end
end
