class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :verify_room, only: [:create, :update]
  before_action :rooms_list, only: [:new, :edit, :create, :update]
  # GET /bookings
  # GET /bookings.json
  def index
    params[:page] = 1 if params[:page].blank?
    @bookings = Booking.page(params[:page]).per(50)
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = current_user.bookings.create(booking_params)
    return render :new  if @booking.errors.present?
    redirect_to bookings_path, notice: 'Booking was successfully created.'
  end

  def update
    return render :edit unless @booking.update_attributes(booking_params)
    redirect_to bookings_path, notice: 'Booking was successfully updated.'
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: 'Booking was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = current_user.bookings.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:room_id, :start_date, :end_date, :status)
    end

    def verify_room
      #redirect_to new_booking_path, warning: 'Room does not exist.' unless Room.find_by_id(booking_params[:room_id])
    end

    def rooms_list
      @rooms = Room.all.select(:id, :title, :room_no)
    end
end
