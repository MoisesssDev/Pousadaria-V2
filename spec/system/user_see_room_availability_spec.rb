require 'rails_helper'

describe 'user see room availability' do
  it 'and see form' do
    # Arrange
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
      daily_rate: 150.00,
      has_private_bathroom: true,
      has_balcony: true,
      has_air_conditioning: true,
      has_tv: false,
      has_wardrobe: true,
      is_accessible: true,
      has_cofre: false,
      available: true
    )

    # Act
    visit root_path
    click_on "Pousada Renascer"
    click_on "Fazer reserva"


    # Assert
    expect(page).to have_content 'Quarto Sol'
    expect(page).to have_content 'Descrição da sala'
    expect(page).to have_content 'Área: 30m²'
    expect(page).to have_content 'Quantidade máxima de pessoas: 2'
    expect(page).to have_field 'Data de entrada'
    expect(page).to have_field 'Data de saída'
    expect(page).to have_field 'Quantidade de hóspedes'

  end

  it 'and see total price' do
    # Arrange
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
      daily_rate: 150.00,
      has_private_bathroom: true,
      has_balcony: true,
      has_air_conditioning: true,
      has_tv: false,
      has_wardrobe: true,
      is_accessible: true,
      has_cofre: false,
      available: true
    )

    # Act
    visit root_path

    click_on "Pousada Renascer"
    click_on "Fazer reserva"

    fill_in "Data de entrada", with: "2023-12-11"
    fill_in "Data de saída", with: "2023-12-13" 
    select "2", from: "Quantidade de hóspedes"

    click_on "Verificar Disponibilidade"


    # Assert
    expect(page).to have_content 'Valor total: R$ 300,00'
    expect(page).to have_button 'Confirmar reserva'

  end
  
  it 'and there is already a reservation for that date' do
    # Arrange
    Client.create!(email: "moises@teste.com", password: "123456mo", full_name: "Moises Almeida Leite", cpf: "09032145622")
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
      daily_rate: 150.00,
      has_private_bathroom: true,
      has_balcony: true,
      has_air_conditioning: true,
      has_tv: false,
      has_wardrobe: true,
      is_accessible: true,
      has_cofre: false,
      available: true
    )

    reservation = room.reservations.create!(entry_date: "2023-12-11", departure_date: "2023-12-13", number_of_guests: 2, client_id: 1)

    # Act
    visit root_path

    click_on "Pousada Renascer"
    click_on "Fazer reserva"

    fill_in "Data de entrada", with: "2023-12-11"
    fill_in "Data de saída", with: "2023-12-13"
    select "2", from: "Quantidade de hóspedes"

    click_on "Verificar Disponibilidade"


    # Assert
    expect(page).to have_content 'Já existe uma reserva para esta data.'
    expect(page).not_to have_button 'Confirmar reserva'

  end
end