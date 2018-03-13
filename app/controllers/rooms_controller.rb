class RoomsController < ApplicationController
  before_action :require_authentication, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  def index
    @rooms = Room.most_recent
  end

  # GET /rooms/1
  def show
    set_room
  end

  # GET /rooms/new
  def new
    # @room = Room.new
    @room = current_user.rooms.build
  end

  # GET /rooms/1/edit
  def edit
    set_room_current_user
  end

  # POST /rooms
  def create
    # @room=Room.new(params[:room]) 
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: t('flash.notice.room_created')
    else
      render :new
    end
  end

  # PATCH/PUT /rooms/1
  def update
    set_room_current_user
    if @room.update(room_params)
      redirect_to @room, notice: t('flash.notice.room_updated')
    else
      render :edit
    end
  end

  # DELETE /rooms/1
  def destroy
    set_room_current_user
    @room.destroy
    redirect_to rooms_url, notice: t('flash.notice.room_deleted')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    def set_room_current_user
      @room = current_user.rooms.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end
