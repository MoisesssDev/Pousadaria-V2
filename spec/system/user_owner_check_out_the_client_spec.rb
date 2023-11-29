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
    visit root_path
    click_on "Entrar / Cadastrar"
    fill_in "E-mail",	with: "moisesalmeida@gmail.com"
    fill_in "Senha",	with: "110302" 

    within ".actions" do
      click_on "Entrar"
    end

    click_on "Estadias ativas"
    click_on r1.code
    fill_in "Meio de pagamento utilizado:",	with: "Pix"
    click_on "Realizar check-out"

    # Assert
    expect(page).to have_content "Check-out realizado com sucesso."
    expect(page).to have_content "Quarto Sol"
    expect(page).to have_content "Data de entrada: " + formatted_entry_date_r1
    expect(page).to have_content "Data de saída: " + formatted_departure_date_r1
    expect(page).to have_content "Quantidade de hóspedes: 2"
    expect(page).to have_content "Total pago: R$ 100,00"
    expect(page).to have_content "Meio de pagamento utilizado: Pix"
    expect(page).to have_content "Estadia finalizada"
    
  end

  it 'after 1 day the departure date' do
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
    formatted_entry_date_r1 = r1.entry_date.strftime("%d/%m/%Y")
    formatted_departure_date_r1 = r1.departure_date.strftime("%d/%m/%Y")
    
    r1.check_in

    # Act
    Timecop.travel(r1.departure_date + 24.hours) do
      visit root_path
      click_on "Entrar / Cadastrar"
      fill_in "E-mail",	with: "moisesalmeida@gmail.com"
      fill_in "Senha",	with: "110302"

      within ".actions" do
        click_on "Entrar"
      end

      click_on "Estadias ativas"
      click_on r1.code
      fill_in "Meio de pagamento utilizado:",	with: "Pix"
      click_on "Realizar check-out"

      # Assert
      expect(page).to have_content "Check-out realizado com sucesso."
      expect(page).to have_content "Quarto Sol"
      expect(page).to have_content "Data de entrada: " + formatted_entry_date_r1
      expect(page).to have_content "Data de saída: " + formatted_departure_date_r1
      expect(page).to have_content "Quantidade de hóspedes: 2"
      expect(page).to have_content "Total pago: R$ 200,00"
      expect(page).to have_content "Meio de pagamento utilizado: Pix"
      expect(page).to have_content "Estadia finalizada"
    end
  end

  it 'after 2 hours the departure date' do
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
    formatted_entry_date_r1 = r1.entry_date.strftime("%d/%m/%Y")
    formatted_departure_date_r1 = r1.departure_date.strftime("%d/%m/%Y")
    
    r1.check_in

    # Act
    Timecop.travel(r1.departure_date + 17.hours) do
      visit root_path
      click_on "Entrar / Cadastrar"
      fill_in "E-mail",	with: "moisesalmeida@gmail.com"
      fill_in "Senha",	with: "110302"

      within ".actions" do
        click_on "Entrar"
      end

      click_on "Estadias ativas"
      click_on r1.code
      fill_in "Meio de pagamento utilizado:",	with: "Pix"
      click_on "Realizar check-out"

      # Assert
      expect(page).to have_content "Check-out realizado com sucesso."
      expect(page).to have_content "Quarto Sol"
      expect(page).to have_content "Data de entrada: " + formatted_entry_date_r1
      expect(page).to have_content "Data de saída: " + formatted_departure_date_r1
      expect(page).to have_content "Quantidade de hóspedes: 2"
      expect(page).to have_content "Total pago: R$ 200,00"
      expect(page).to have_content "Meio de pagamento utilizado: Pix"
      expect(page).to have_content "Estadia finalizada"
    end
  end

end