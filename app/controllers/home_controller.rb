class HomeController < ApplicationController
  def index
    @rooms = Room.all.order(name: :asc)
    @current_room = Room.find(params[:room_id]) if params[:room_id]

    if @current_room
      @messages = @current_room.messages.order(created_at: :asc)
      @message = @current_room.messages.build
    end
  end
end
