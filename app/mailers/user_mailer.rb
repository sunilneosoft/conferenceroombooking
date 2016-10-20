class UserMailer < ApplicationMailer

	def welcome(user)
		@user = user
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Registered")
	end

	def booking_confirmation(user)
		@user = user
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Booking Confirmation")
    end

    def waiting_rooms(user)
    	@user = user
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Booking Waiting")
    end

    def booking_cancellation(user)
    	@user = user
        mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Booking Cancellation")
    end
end
