require 'rails_helper'

describe 'user view reservations' do
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

    Reservation.create!(
      entry_date: Time.now,
      departure_date: Time.now.tomorrow,
      number_of_guests: 2,
      room: room,
      total_price: 200.0,
      client: client,
      guesthouse: guesthouse,
    )

    Reservation.create!(
      entry_date: Time.now.tomorrow,
      departure_date: Time.now.tomorrow + 3.days,
      number_of_guests: 3,
      room: room, 
      total_price: 300.0,
      client: client,
      guesthouse: guesthouse,
    )

    # Act
    visit root_path
    click_on "Entrar / Cadastrar"
    click_on "aqui"
    fill_in "E-mail",	with: "moises@teste.com"
    fill_in "Senha",	with: "123456mo" 

    within ".actions" do
      click_on "Entrar"
    end
    click_on "Minhas reservas"


    # Assert
    expect(page).to have_content "Código" 
    expect(page).to have_content "Pousada Renascer"
    expect(page).to have_content "Quarto Sol"
    expect(page).to have_content "Confirmada"

    expect(page).to have_content "Código" 
    expect(page).to have_content "Pousada Renascer"
    expect(page).to have_content "Confirmada"
    
  end
 
  it 'and has no reservations' do
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

    # Act
    visit root_path
    click_on "Entrar / Cadastrar"
    click_on "aqui"
    fill_in "E-mail",	with: "moises@teste.com"
    fill_in "Senha",	with: "123456mo" 

    within ".actions" do
      click_on "Entrar"
    end
    click_on "Minhas reservas"


    # Assert
    expect(page).to have_content "Não possui nenhuma reserva" 
    
  end
end