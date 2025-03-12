class MessagesController < ApplicationController
  before_action :set_room, only: %i[ index new create ]
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  def index
    if params[:room_id]
      @room = Room.find(params[:room_id])
      @messages = @room.messages.order(created_at: :desc)
    else
      @messages = Message.all.order(created_at: :desc)
    end
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = @room.messages.build
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream
        format.html { redirect_to root_path(room_id: @room.id) }
      else
        format.html { redirect_to root_path(room_id: @room.id), alert: @message.errors.full_messages.join(', ') }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_path(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    room = @message.room
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to room_path(room), status: :see_other, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:content)
    end

    def set_room
      @room = Room.find(params[:room_id]) if params[:room_id]
    end
end
