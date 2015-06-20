class BookingsController < ApplicationController

  before_action :require_user, only: [:new]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      redirect_to bookings_path, notice: 'Your booking has been sucessfully submitted'
    else
      flash[:alert] = 'Opps, thas was embarrassing. Try again?'
      render 'new'
    end
  end

  def set_open
    @booking.update_attributes(status: 0)
    redirect_to bookings_path
  end

  def set_close
    @booking.update_attributes(status: 1)
    redirect_to bookings_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:item_id, :quantity, :start_date, :end_date)
  end

end
