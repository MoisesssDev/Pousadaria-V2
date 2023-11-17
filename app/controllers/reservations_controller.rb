class ReservationsController < ApplicationController
  before_action :find_room, only: [:new, :check_availability]
  
  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def check_availability
    @reservation = Reservation.new(reservation_params)
    
    start_date = @reservation.entry_date
    end_date = @reservation.departure_date

    if reservation_exists?(start_date, end_date)
      @message = 'Já existe uma reserva para esta data.'
      @total_price = nil
    else
      @total_price = calculate_total_price(start_date, end_date)
      @message = "Valor total: R$ #{@total_price}"
    end
  
    render 'new', status: :partial_content
  end

  private

  def reservation_params
    params.require(:reservation).permit(:entry_date, :departure_date, :number_of_guests)
  end

  def find_room
    @room = Room.find(params[:room_id])
  end

  def reservation_exists?(start_date, end_date)
    Reservation.where(room_id: @room.id)
             .where('(entry_date BETWEEN ? AND ?) OR (departure_date BETWEEN ? AND ?) OR (entry_date <= ? AND departure_date >= ?)',
                    start_date, end_date, start_date, end_date, start_date, end_date)
             .present?
  end

  def calculate_total_price(start_date, end_date)
    return 0 if start_date.nil? || end_date.nil?

    price_per_night = @room.daily_rate
    total_nights = (end_date - start_date).to_i
  
    total_price = price_per_night * total_nights
    
    format('%.2f', total_price).tr('.', ',')
  end

end
