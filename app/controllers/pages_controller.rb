class PagesController < ApplicationController

  before_action :require_user, only: [:booking]

  def index
    if current_user
      @user_bookings = current_user.bookings
    end
  end

  def booking
    @user_bookings = current_user.bookings
  end

end
