class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show update ]
  before_action :set_mole, only: %i[ create ]

  def show
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.mole = @mole
    @booking.user = current_user

    if @booking.save
      redirect_to booking_path(@booking), notice: "You made a reservation to rent #{@mole.full_name}, #{ [ 'a great', 'a wonderful', 'an amazing', 'a superb', '' ].sample } mole. Now let's wait for #{@mole.owner_full_name} to confirm this reservation."
    else
      flash.now[:alert] = "Your demand could not be processed #{@mole.full_name}, please review any errors below."
      render :new
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      flash.now[:alert] = "#{@booking.full_name} couldn't be updated, please review any errors below."
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :dob, :weight, :length, :width, :height, :shade, :address)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_mole
    @mole = Mole.find(params[:mole_id])
  end
end

