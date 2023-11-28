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
        @total_price = calculate_total_price(start_date, end_date)
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
        # Limpe as informações de reserva armazenadas na sessão
        session[:reserva_info] = nil

        # Redirecione para a página de confirmação ou outra página relevante
        redirect_to room_reservation_path(@room, @reservation), notice: "Reserva criada com sucesso."
      else
        # Trate o caso em que a reserva não pode ser salva
        flash[:alert] = 'Erro ao confirmar a reserva. Por favor, tente novamente.'
        render 'new', status: :unprocessable_entity
      end
    else
      # Se o usuário não estiver logado, redirecione para a página de login
      flash[:notice] = 'Faça login para confirmar a reserva.'
      store_location_for(:client, new_room_reservation_path)
      redirect_to new_client_session_path
    end
  end

  def show 
    @reservation = Reservation.find(params[:id])
  end

  def index
    if client_signed_in?
      @reservations = current_client.reservations
    end
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
