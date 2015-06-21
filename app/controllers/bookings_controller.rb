class BookingsController < ApplicationController

  before_action :require_user, only: [:new]
  before_action :set_booking, only: [:set_open, :set_close, :update]
  # before_action :require_admin, only: [:index, :update]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      redirect_to root_path, notice: 'Your booking has been sucessfully submitted'
    else
      flash[:alert] = 'Opps, thas was embarrassing. Try again?'
      render 'new'
    end
  end

  def set_open
    adjust_quantity = @booking.item.quantity - @booking.quantity
    @booking.update_attributes(status: 0)
    @booking.item.update_attributes(:quantity => adjust_quantity)
    redirect_to bookings_path
  end

  def set_close
    @booking.update_attributes(status: 1)
    adjust_quantity = @booking.quantity + @booking.item.quantity
    if @booking.item.returnable?
      @booking.item.update_attributes(:quantity => adjust_quantity)
    end
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
