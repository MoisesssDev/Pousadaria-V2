require 'rails_helper'

describe 'user owner check-out the client' do
  it 'sucessfully' do
    # Arrange
    client = Client.create!(email: "moises@teste.com", password: "123456mo", full_name: "Moises Almeida Leite", cpf: "09032145622")
    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    guesthouse = user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                    cnpj: "12345678901234", phone: "79 98837-7894",
                                    email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                    state: "Rio de Janeiro", city: "João Pessoa", cep: "89700-218",
                                    description: "Descrição da Pousada", accepted_payment_methods: "Cartão, Pix ou Boleto",
                                    accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")
    room = guesthouse.rooms.create!(
      name: "Quarto Sol",
      description: "Descrição da sala",
      dimension: 30,
      max_occupancy: 2,
      daily_rate: 100.00,
      has_private_bathroom: true,
      has_balcony: true,
      has_air_conditioning: true,
      has_tv: false,
      has_wardrobe: true,
      is_accessible: true,
      has_cofre: false,
      available: true
    )

    r1 = Reservation.create!(
      entry_date: Time.now,
      departure_date: Time.now.tomorrow,
      number_of_guests: 2,
      room: room,
      total_price: 100.0,
      client: client,
      guesthouse: guesthouse,
    )
    formatted_entry_date_r1 = Time.now.strftime("%d/%m/%Y")
    formatted_departure_date_r1 = Time.now.tomorrow.strftime("%d/%m/%Y")
    
    r1.check_in

    # Act
    Timecop.travel(r1.departure_date) do
      total_paid = format('%.2f', 100.0).tr('.', ',')
      payment_method = "Cartão de crédito"
      r1.checkout(total_paid, payment_method)

      visit root_path
      click_on "Entrar / Cadastrar"
      click_on "aqui"
      fill_in "E-mail",	with: "moises@teste.com"
      fill_in "Senha",	with: "123456mo"

      within ".actions" do
        click_on "Entrar"
      end

      click_on "Minhas reservas"
      click_on r1.code
      fill_in "Comentários",	with: "Gostei bastante da estadia!!!"
      select "4", from: "Avaliação"
      click_on "Fazer avaliação"

      # Assert
      expect(page).to have_content "Avaliação cadastrada com sucesso"
    end
    
  end

end