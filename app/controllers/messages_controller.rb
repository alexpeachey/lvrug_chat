class MessagesController < ApplicationController

  def index
  end

  def create
    if current_user
      name = current_user.name
      message = ActionController::Base.helpers.sanitize(params['message'])
      PUBLISHER.publish('/chat', {name: name, message: message}.to_json)
      head :ok
    else
      head :unauthorized
    end
  end
end
