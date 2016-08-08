class BookingMailer < ApplicationMailer
	default from: 'hongchiong@gmail.com'

	def booking_email(user, booking)
		@user = user
		@booking = booking
		@url = 'http://localhost:3000/sign_in'
		mail(to: @user.email, subject: 'Booking Pairbnb')
	end
end
