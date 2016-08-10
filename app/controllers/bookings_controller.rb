class BookingsController < ApplicationController


  def create
    @listing = Listing.find(params[:listing_id])
    @booking = current_user.bookings.new(booking_params)
    @booking.listing = @listing

    if @booking.save
      amount = @listing.price * params[:booking][:num_guests].to_i
 # In production you should not take amounts directly from clients
      nonce = params[:payment_method_nonce]

      result = Braintree::Transaction.sale(
        amount: amount,
        payment_method_nonce: nonce,
        :options => {
          :submit_for_settlement => true
        }
      )

      if result.success? || result.transaction
        BookingMailer.booking_email(current_user, @booking).deliver_later
        redirect_to @listing
      else
        @booking = Booking.find(params[:id])
        @booking.destroy
        error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
        flash[:error] = error_messages
        redirect_to listing_path
      end

    else
      @errors = @booking.errors.full_messages
      render "listings/show"
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to @booking.user
  end

  def booking_params
    params.require(:booking).permit(:num_guests, :start_date, :end_date)
  end
end