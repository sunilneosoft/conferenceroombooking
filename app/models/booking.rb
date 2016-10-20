class Booking < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  
  after_initialize :init

  # after_save :check_status
  before_save :check_status

  validates :start_date, :end_date, presence: true
  
  default_scope -> { where.not(status: CANCEL) }
  
  def init
    self.status ||= ALLOTED
  end

  def check_status
    case self.status
    when ALLOTED, WAITING
      if datetime_slot_available?
        self.room.update_column('status', ALLOTED) if self.room.status != ALLOTED
        self.status = ALLOTED
      elsif
        self.status = WAITING
      end
    when CANCEL
      free_room_for_booking
    else
    end
  end

  def free_room_for_booking
    self.room.update_column('status', FREE)
    upcomming_booking = upcomming_bookings.first
    if upcomming_booking
      upcomming_booking.update_column('status', ALLOTED)
      upcomming_booking.room.update_column('status', ALLOTED)
    end
  end
  
  def upcomming_bookings
    Booking.where(room_id: self.room_id, status: [WAITING]).where.not(id: self.id).order("start_date ASC")
  end

  def datetime_slot_available?
    not Booking.where(room_id: self.room_id, status: [ALLOTED, WAITING], start_date: self.start_date..self.end_date).where.not(id: self.id).present?
  end


end
