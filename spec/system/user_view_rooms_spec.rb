require 'rails_helper'

describe 'user views rooms in the guesthouse' do
  it 'and see all fields' do
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
      available: true,
    )

    # Act
    visit root_path
    click_on "Pousada Renascer"

    # Assert
    expect(page).to have_content('Quarto Sol')
    expect(page).to have_content('Descrição da sala')
    expect(page).to have_content('Área: 30')
    expect(page).to have_content('Quantidade máxima de pessoas: 2')
    expect(page).to have_content('R$150,00')
    expect(page).to have_content('Tem banheiro')
    expect(page).to have_content('Tem varanda')
    expect(page).to have_content('Tem ar-condicionado')
    expect(page).to have_content('Não tem TV')
    expect(page).to have_content('Tem guarda-roupa')
    expect(page).to have_content('Acessível')
    expect(page).to have_content('Não tem cofre')
    expect(page).to have_link('Fazer reserva')

  end

  it 'and it does not show the unavailable rooms' do
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
      available: false,
    )

    # Act
    visit root_path
    click_on "Pousada Renascer"

    # Assert
    expect(page).to have_content('Não possui nenhum quarto disponível')

  end

  it 'and view all available and unavailable rooms' do
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
      available: false
    )
    room = guesthouse.rooms.create!(
      name: "Quarto Lua",
      description: "Descrição da sala",
      dimension: 25,
      max_occupancy: 2,
      daily_rate: 110.00,
      has_private_bathroom: true,
      has_balcony: true,
      has_air_conditioning: true,
      has_tv: false,
      has_wardrobe: true,
      is_accessible: true,
      has_cofre: false,
      available: false
    )

    # Act
    visit root_path
    click_on "Entrar / Cadastrar"

    fill_in "E-mail",	with: "moisesalmeida@gmail.com"
    fill_in "Senha",	with: "110302"
    within ".actions" do
      click_on "Entrar"
    end

    click_on "Minha pousada"
    click_on "Ver quartos desabilitados"

    # Assert
    expect(page).to have_content('Quartos desabilitados')  
    expect(page).to have_content('Quarto Sol')
    expect(page).to have_content('Descrição da sala')
    expect(page).to have_content('Área: 30')
    expect(page).to have_content('Quantidade máxima de pessoas: 2')
    expect(page).to have_content('R$150,00')
    expect(page).to have_content('Tem banheiro')
    expect(page).to have_content('Tem varanda')
    expect(page).to have_content('Tem ar-condicionado')
    expect(page).to have_content('Não tem TV')
    expect(page).to have_content('Tem guarda-roupa')
    expect(page).to have_content('Acessível')
    expect(page).to have_content('Não tem cofre')

    expect(page).to have_content('Quarto Lua')
    expect(page).to have_content('Descrição da sala')
    expect(page).to have_content('Área: 25')
    expect(page).to have_content('Quantidade máxima de pessoas: 2')
    expect(page).to have_content('R$110,00')
    expect(page).to have_content('Tem banheiro')
    expect(page).to have_content('Tem varanda')
    expect(page).to have_content('Tem ar-condicionado')
    expect(page).to have_content('Não tem TV')
    expect(page).to have_content('Tem guarda-roupa')
    expect(page).to have_content('Acessível')
    expect(page).to have_content('Não tem cofre')

  end
  
end