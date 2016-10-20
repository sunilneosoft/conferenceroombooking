class Admin::RoomsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :facility_ids, only: [:new, :edit, :create, :update]

  def index
    params[:page] = 1 if params[:page].blank?
    @rooms = Room.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
    @room_facility_ids = @room.facilities.pluck(:id)
  end

  def create
    @room = Room.create(room_params)
    return render :new  if @room.errors.present?
    redirect_to rooms_path, notice: 'room was successfully created.'
  end

  def update
    return render :edit if not @room.update(room_params)
    redirect_to rooms_path, notice: 'room was successfully updated.'
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: 'room was successfully destroyed.'
  end

  private

    def facility_ids
      @facilities = Facility.select(:id, :title)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit!
    end
end
