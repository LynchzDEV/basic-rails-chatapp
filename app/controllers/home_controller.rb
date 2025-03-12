class HomeController < ApplicationController
  def index
    @rooms = Room.all.order(name: :asc)
    @current_room = Room.find(params[:room_id]) if params[:room_id]

    if @current_room
      @messages = @current_room.messages.order(created_at: :asc)
      @message = @current_room.messages.build
    end
  end

  def cable_test
    if params[:room_id]
      @room = Room.find(params[:room_id])
      ActionCable.server.broadcast(
        "#{@room.id}_messages",
        { html: "<div>Test message at #{Time.now.strftime('%H:%M:%S')}</div>" }
      )
      render plain: "Test broadcast sent to room #{@room.id}"
    else
      render plain: "Please provide a room_id parameter"
    end
  end
end
