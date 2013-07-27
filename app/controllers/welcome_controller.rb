class WelcomeController < ApplicationController
  def index
    @boxes = Box.where(user_id: current_user.id) if current_user
  end
end
