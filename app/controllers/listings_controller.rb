class ListingsController < ApplicationController
  before_action :find_listing, only: [:show, :edit, :update]

  def index
    @filterrific = initialize_filterrific(
      Listing,
      params[:filterrific],
      select_options: {
        sorted_by: Listing.options_for_sorted_by,
        with_country_id: Listing.countries_with_listings,
        with_tag_ids: Tag.options_for_select
      }
    ) or return

    @listings = @filterrific.find
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to listings_path
    end
  end

  def show
    @booking = @listing.bookings.new
    @client_token = Braintree::ClientToken.generate
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      flash[:success] = "Successfully updated the listing"
      redirect_to @listing
    else
      flash[:danger] = "Error updating listing"
      render :edit
    end
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :max_guests, :price, :country_code, tag_ids: [])
  end
end
