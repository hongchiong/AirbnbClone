class BookingsController < ApplicationController
  def create
    @listing = Listing.find(params[:listing_id])
    @booking = current_user.bookings.new(booking_params)
    @booking.listing = @listing
    if @booking.save
      redirect_to current_user
    else
      render "listings/show"
    end
  end

  def destroy
  end

  def booking_params
    params.require(:booking).permit(:num_guests, :start_date, :end_date)
  end
end
