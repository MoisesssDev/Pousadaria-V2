class ReservationsController < ApplicationController
  before_action :find_room, only: [:new, :check_availability, :create, :show]
  
  def new
    @reservation = Reservation.new

    if session[:reservation_data].present?
      @reservation.assign_attributes(session[:reservation_data])
      session[:reservation_data] = nil
    end
  end

  def check_availability
    @reservation = Reservation.new(reservation_params)
    @reservation.room = @room

    if @reservation.valid?
      start_date = @reservation.entry_date
      end_date = @reservation.departure_date
      number_of_guests = @reservation.number_of_guests
      
      if reservation_exists?(start_date, end_date)
        @message = 'Já existe uma reserva para esta data.'
        @total_price = nil
      else
        @total_price = calculate_total_price(start_date, end_date, @room.daily_rate)
        @message = "Quarto disponível para essa data. Valor total: R$ #{@total_price}"

        session[:reservation_data] = {
          entry_date: start_date,
          departure_date: end_date,
          number_of_guests: number_of_guests,
          total_price: @total_price,
          room_id: @room.id
        }
      end
    end
  
    render 'new', status: :partial_content
  end

  def create
    if client_signed_in?

      @reservation = current_client.reservations.build
      @reservation.assign_attributes(session[:reservation_data])
      @reservation.guesthouse = @room.guesthouse

      if @reservation.save
        
        session[:reserva_info] = nil

        
        redirect_to room_reservation_path(@room, @reservation), notice: "Reserva criada com sucesso."
      else
        
        flash[:alert] = 'Erro ao confirmar a reserva. Por favor, tente novamente.'
        render 'new', status: :unprocessable_entity
      end
    else
      
      flash[:notice] = 'Faça login para confirmar a reserva.'
      store_location_for(:client, new_room_reservation_path)
      redirect_to new_client_session_path
    end
  end

  def show 
    @reservation = Reservation.find(params[:id])
    if @reservation.review.nil?
      @review = Review.new
    end
  end

  def index
    if client_signed_in?
      @reservations = current_client.reservations
    end

    if owner_signed_in?
      @reservations = current_owner.guesthouse.reservations
    end
  end

  def cancel
    @reservation = current_client.reservations.find(params[:id])

    if @reservation.cancellable?
      @reservation.update(status: :canceled)
      flash[:notice] = 'Reserva cancelada com sucesso.'
    else
      flash[:alert] = 'Não é possível cancelar esta reserva.'
    end

    redirect_to reservations_path
  end

  def check_in
    @reservation = Reservation.find(params[:reservation_id])
    if @reservation.check_in
      redirect_to reservations_path, notice: 'Check-in realizado com sucesso.'
    else
      redirect_to reservations_path, notice: @reservation.errors.full_messages.join(', ')
    end
  end

  def check_out
    @reservation = Reservation.find(params[:reservation_id])
    total_paid = calculate_total_paid(@reservation)
    payment_method = params[:reservation][:payment_method]


    if @reservation.checkout(total_paid, payment_method)
      redirect_to room_reservation_path(@reservation.room, @reservation), notice: 'Check-out realizado com sucesso.'
    else
      flash[:alert] = 'Erro ao realizar o check-out.'
      puts @reservation.errors.full_messages.join(', ')
      redirect_to room_reservation_path(@reservation.room, @reservation)
    end
  end

  def active_stays
    @guesthouse = current_owner.guesthouse
    @active_stays = @guesthouse.reservations.active_stays
  end

  private

  def calculate_total_paid(reservation)
    check_out_time = reservation.guesthouse.check_out_time
    check_out_datetime = reservation.departure_date.to_time.change(hour: check_out_time.hour, min: check_out_time.min)
  
    if Time.now.to_date > check_out_datetime.to_date
      calculate_total_price(reservation.entry_date, Time.now, reservation.room.daily_rate)
    elsif Time.now > check_out_datetime
      calculate_total_price(reservation.entry_date, Time.now.tomorrow, reservation.room.daily_rate)
    else
      reservation.total_price
    end
  end

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

  def calculate_total_price(start_date, end_date, price_per_night)
    new_start_date = Date.new(start_date.year, start_date.month, start_date.day)
    new_end_date = Date.new(end_date.year, end_date.month, end_date.day)

    total_nights = (new_end_date - new_start_date).to_i
  
    total_price = price_per_night * total_nights
    format('%.2f', total_price).tr('.', ',')
  end

end
