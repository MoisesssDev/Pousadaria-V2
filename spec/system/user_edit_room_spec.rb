require 'rails_helper'

describe 'user edit room in the guesthouse' do
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
    within ".actions" do
      click_on "Entrar"
    end

    click_on "Minha pousada"
    click_on "Quarto Sol"
    click_on "Editar quarto"


    # Assert
    expect(page).to have_content 'Editar quarto'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área'
    expect(page).to have_field 'Quantidade máxima de pessoas'
    expect(page).to have_field 'Diária'
    expect(page).to have_field 'Tem banheiro'
    expect(page).to have_field 'Tem varanda'
    expect(page).to have_field 'Tem ar-condicionado'
    expect(page).to have_field 'Tem TV'
    expect(page).to have_field 'Tem guarda-roupa'
    expect(page).to have_field 'É acessível'
    expect(page).to have_field 'Tem cofre'
    expect(page).to have_field 'ativo'

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
    within ".actions" do
      click_on "Entrar"
    end

    click_on "Minha pousada"
    click_on "Quarto Sol"
    click_on "Editar quarto"

    fill_in "Nome", with: "Quarto Solar"
    fill_in "Descrição", with: "Uma descrição de exemplo"
    fill_in "Área", with: 20
    fill_in "Quantidade máxima de pessoas", with: 2
    fill_in "Diária", with: 90.50

    check "Tem banheiro"
    check "Tem varanda"
    check "Tem ar-condicionado"
    uncheck "Tem TV"
    uncheck "Tem guarda-roupa"
    check "É acessível"
    check "Tem cofre"
    check "ativo"

    click_on "Salvar"


    # Assert
    expect(page).to have_content 'Quarto atualizado com sucesso'  
    expect(page).to have_content 'Quarto Solar'
    expect(page).to have_content 'R$90,50'
    expect(page).not_to have_content 'Possui TV'
    expect(page).not_to have_content 'Tem guarda-roupa'

  end
  
end