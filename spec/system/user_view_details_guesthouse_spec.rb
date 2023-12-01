require 'rails_helper'

describe 'User view guesthouses details' do
  it 'and see all fields' do
    # Arrange
    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    guesthouse = user.build_guesthouse(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "João Pessoa", cep: "89700-218",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Cartão, Pix ou Boleto",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")
    guesthouse.save

    # Act
    visit root_path
    click_on "Pousada Renascer"

    # Assert
    expect(page).to have_content('Pousada Renascer')
    expect(page).to have_content('79 98837-7894')
    expect(page).to have_content('Rua Alemedo, 54')
    expect(page).to have_content('Cocora')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('João Pessoa')
    expect(page).to have_content('89700-218')
    expect(page).to have_content('Descrição da Pousada')
    expect(page).to have_content('Cartão, Pix ou Boleto')
    expect(page).to have_content('Aceita pets')
    expect(page).to have_content('Políticas de Uso da Pousada')
    expect(page).to have_content('Check-in: 10:00')
    expect(page).to have_content('Check-out: 14:00')

  end

  it 'see average score, last 3 reviews received and button to see all reviews' do
    # Arrange
    client = Client.create!(email: "moises@teste.com", password: "123456mo", full_name: "Moises Almeida Leite", cpf: "09032145622")
    client2 = Client.create!(email: "fernando@teste.com", password: "123456mo", full_name: "Fernando Henrique Leite", cpf: "08532145622")
    client3 = Client.create!(email: "gustavo@teste.com", password: "123456mo", full_name: "Gustavo Pereira da Silva", cpf: "01237155622")
    client4 = Client.create!(email: "paulo@teste.com", password: "123456mo", full_name: "Paulo Ricardo Nascimento", cpf: "09089070622")

    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    guesthouse = user.build_guesthouse(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "João Pessoa", cep: "89700-218",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Cartão, Pix ou Boleto",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")
    guesthouse.save

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
    room2 = guesthouse.rooms.create!(
      name: "Quarto Lua",
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
    room3 = guesthouse.rooms.create!(
      name: "Quarto Carnaval",
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
    room4 = guesthouse.rooms.create!(
      name: "Quarto Ano Novo",
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
    r2 = Reservation.create!(
      entry_date: Time.now,
      departure_date: Time.now.tomorrow,
      number_of_guests: 2,
      room: room2,
      total_price: 100.0,
      client: client2,
      guesthouse: guesthouse,
    )
    r3 = Reservation.create!(
      entry_date: Time.now,
      departure_date: Time.now.tomorrow,
      number_of_guests: 2,
      room: room3,
      total_price: 100.0,
      client: client3,
      guesthouse: guesthouse,
    )
    r4 = Reservation.create!(
      entry_date: Time.now,
      departure_date: Time.now.tomorrow,
      number_of_guests: 2,
      room: room4,
      total_price: 100.0,
      client: client4,
      guesthouse: guesthouse,
    )
    r1.check_in
    r2.check_in
    r3.check_in
    r4.check_in

    Timecop.travel(r1.departure_date) do
      total_paid = format('%.2f', 100.0).tr('.', ',')
      payment_method = "Cartão de crédito"
      r1.checkout(total_paid, payment_method)
      r1.create_review!(comment: "Gostei bastante da estadia!!!", rating: 4, guesthouse: guesthouse)

      r2.checkout(total_paid, payment_method)
      r2.create_review!(comment: "Poderia ter sido melhor!!!", rating: 2, guesthouse: guesthouse)

      r3.checkout(total_paid, payment_method)
      r3.create_review!(comment: "Gostei muito da vista do quarto!!!", rating: 5, guesthouse: guesthouse)

      r4.checkout(total_paid, payment_method)
      r4.create_review!(comment: "Não gostei do atendimento!!!", rating: 1, guesthouse: guesthouse)

      # Act
      visit root_path

      click_on "Pousada Renascer"

      # Assert
      expect(page).to have_content "3,00 / 5.0"
      expect(page).to have_content client.full_name
      expect(page).to have_content "Gostei bastante da estadia!!!"
      expect(page).to have_content "Nota: 4"
      expect(page).to have_content client2.full_name
      expect(page).to have_content "Poderia ter sido melhor!!!"
      expect(page).to have_content "Nota: 2"
      expect(page).to have_content client3.full_name
      expect(page).to have_content "Gostei muito da vista do quarto!!!"
      expect(page).to have_content "Nota: 5"
      expect(page).to have_link "Ver todas as avaliações"
    end
  end
  
end