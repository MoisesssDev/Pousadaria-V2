require 'rails_helper'

describe 'user owner view reviews' do
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
    r1.check_in

    Timecop.travel(r1.departure_date) do
      total_paid = format('%.2f', 100.0).tr('.', ',')
      payment_method = "Cartão de crédito"
      r1.checkout(total_paid, payment_method)
      r1.create_review!(comment: "Gostei bastante da estadia!!!", rating: 4, guesthouse: guesthouse)

      formatted_check_in_date_r1 = r1.check_in_date.strftime("%d/%m/%Y")
      formatted_check_out_date_r1 = r1.checkout_date.strftime("%d/%m/%Y")

      # Act
      visit root_path
      click_on "Entrar / Cadastrar"
      fill_in "E-mail",	with: "moisesalmeida@gmail.com"
      fill_in "Senha",	with: "110302"

      within ".actions" do
        click_on "Entrar"
      end

      click_on "Minha pousada"
      click_on "Avaliações"

      # Assert
      expect(page).to have_content "Código"
      expect(page).to have_content r1.code
      expect(page).to have_content "Quarto Sol"
      expect(page).to have_content "Data de check-in: " + formatted_check_in_date_r1
      expect(page).to have_content "Data de check-out: " + formatted_check_out_date_r1
      expect(page).to have_content "Hóspede: " + r1.client.full_name
    end
    
  end

  it 'and has no reviews' do
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
    r1.check_in

    Timecop.travel(r1.departure_date) do
      total_paid = format('%.2f', 100.0).tr('.', ',')
      payment_method = "Cartão de crédito"
      r1.checkout(total_paid, payment_method)

      formatted_check_in_date_r1 = r1.check_in_date.strftime("%d/%m/%Y")
      formatted_check_out_date_r1 = r1.checkout_date.strftime("%d/%m/%Y")

      # Act
      visit root_path
      click_on "Entrar / Cadastrar"
      fill_in "E-mail",	with: "moisesalmeida@gmail.com"
      fill_in "Senha",	with: "110302"

      within ".actions" do
        click_on "Entrar"
      end

      click_on "Minha pousada"
      click_on "Avaliações"

      # Assert
      expect(page).to have_content "Não possui nenhuma avaliação"
    end
    
  end

end