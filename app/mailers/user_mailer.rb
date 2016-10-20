class UserMailer < ApplicationMailer

	def welcome(user, booking)
		@user = user
        @booking = booking
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Registered")
	end

	def booking_confirmation(user, booking)
		@user = user
        @booking = booking
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Booking Confirmation")
    end

    def waiting_rooms(user, booking)
    	@user = user
        @booking = booking
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Booking Waiting")
    end

    def booking_cancellation(user, booking)
    	@user = user
        @booking = booking
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Booking Cancellation")
    end
end
