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
        UserMailer.booking_confirmation(self.user, self).deliver
      elsif
        self.status = WAITING
        UserMailer.waiting_rooms(self.user, self).deliver
      end
    when CANCEL
      free_room_for_booking
    else
    end
  end

  def free_room_for_booking
    self.room.update_column('status', FREE)
    upcomming_booking = upcomming_bookings.first
    UserMailer.booking_cancellation(self.user, self).deliver
    if upcomming_booking
      upcomming_booking.booking_confirmation_mail
      upcomming_booking.update_column('status', ALLOTED)
      upcomming_booking.room.update_column('status', ALLOTED)
      UserMailer.booking_confirmation(upcomming_booking.user, upcomming_booking).deliver
    end
  end
  
  def upcomming_bookings
    Booking.where(room_id: self.room_id, status: [WAITING]).where.not(id: self.id).order("start_date ASC")
  end

  def datetime_slot_available?
    # not Booking.where(room_id: self.room_id, status: [ALLOTED, WAITING], start_date: self.start_date..self.end_date).where.not(id: self.id).present?
    not Booking.where(room_id: self.room_id, status: [ALLOTED, WAITING]).where(' start_date >= ?', self.start_date.to_formatted_s(:db)).where.not(id: self.id).present?
  end

  def self.close_bookings
    bookings = Booking.where(status: [ALLOTED, WAITING]).where("end_date <= ?", Time.now.to_formatted_s(:db))
    bookings.update_all(status: CANCEL)
  end

end
