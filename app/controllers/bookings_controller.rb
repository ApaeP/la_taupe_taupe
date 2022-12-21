class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show update destroy ]

  def show
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to booking_path(@booking), notice: "#{@booking.full_name} was added to your bookings."
    else
      flash.now[:alert] = "Your new booking couldn't be added to your bookings , please review any errors below."
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

  def destroy
    if @booking.destroy
      redirect_to bookings_path, notice: "#{@booking.full_name} was removed from your bookings."
    else
      redirect_to request.referer, alert: "#{@booking.full_name} couldn't be removed from your bookings. (error: #{@booking.errors.full_messages.join(', ')})"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :dob, :weight, :length, :width, :height, :shade, :address)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end

