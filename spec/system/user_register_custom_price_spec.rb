require 'rails_helper'

describe 'user register custom price in the room' do
  it 'and see form' do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
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
    click_on "Entrar / Cadastrar"

    fill_in "E-mail",	with: "moisesalmeida@gmail.com"
    fill_in "Senha",	with: "110302"
    within "form" do
      click_on "Entrar"
    end

    click_on "Minha pousada"
    click_on "Quarto Sol"
    click_on "Personalizar preços"


    # Assert
    expect(page).to have_field 'Selecione um quarto'
    expect(page).to have_field 'Data inicial'
    expect(page).to have_field 'Data final'
    expect(page).to have_field 'Preço'

  end

  it 'and register successfully' do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
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
    click_on "Entrar / Cadastrar"

    fill_in "E-mail",	with: "moisesalmeida@gmail.com"
    fill_in "Senha",	with: "110302"
    within "form" do
      click_on "Entrar"
    end

    click_on "Minha pousada"
    click_on "Quarto Sol"
    click_on "Personalizar preços"

    select "Quarto Sol", from: "Selecione um quarto"
    fill_in "Data inicial", with: "11/12/2023"
    fill_in "Data final", with: "11/02/2024"
    fill_in "Preço", with: 150

    click_on "Salvar"


    # Assert
    expect(page).to have_content 'Preço personalizado adicionado com sucesso.'  
    expect(page).to have_content 'Horários personalizados'
    expect(page).to have_content 'Período: 11/12/2023 - 11/02/2024'
    expect(page).to have_content 'Preço: R$ 150,00'

  end

  it 'and register overlapping dates' do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
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

    custom_price = CustomPrice.new(start_date: "2023/12/01", end_date: "2024/01/29", price: 125.50, room: room)
    custom_price.save

    # Act
    visit root_path
    click_on "Entrar / Cadastrar"

    fill_in "E-mail",	with: "moisesalmeida@gmail.com"
    fill_in "Senha",	with: "110302"
    within "form" do
      click_on "Entrar"
    end

    click_on "Minha pousada"
    click_on "Quarto Sol"
    click_on "Personalizar preços"

    select "Quarto Sol", from: "Selecione um quarto"
    fill_in "Data inicial", with: "11/12/2023"
    fill_in "Data final", with: "11/02/2024"
    fill_in "Preço", with: 150

    click_on "Salvar"


    # Assert
    expect(page).to have_content 'Já existe um preço definido para essa data'  
    expect(page).to have_content 'Horários personalizados'
    expect(page).to have_content 'Período: 01/12/2023 - 29/01/2024'
    expect(page).to have_content 'Preço: R$ 125,50'

  end
  
end