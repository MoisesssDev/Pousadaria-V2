require 'rails_helper'

describe 'user edit guesthouse' do
  it 'and see form' do
    # Arrange
    owner = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    guesthouse = owner.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "João Pessoa", cep: "89700-218",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Cartão, Pix ou Boleto",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")

    # Act
    visit root_path
    click_on "Entrar / Cadastrar"

    fill_in "E-mail",	with: "moisesalmeida@gmail.com"
    fill_in "Senha",	with: "110302"
    within ".actions" do
      click_button "Entrar"
    end

    click_on "Minha pousada"
    click_on "Editar pousada"


    # Assert
    expect(page).to have_content('Editar pousada')
    expect(page).to have_field('Nome')
    expect(page).to have_field('Razão social')
    expect(page).to have_field('Telefone')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Bairro')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Meios de pagamento')
    expect(page).to have_field('Aceita pets')
    expect(page).to have_field('Políticas')
    expect(page).to have_field('Check-in')
    expect(page).to have_field('Check-out')
    expect(page).to have_field('Ativo')

  end

  it 'and register successfully' do
    # Arrange
    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    guesthouse = user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "João Pessoa", cep: "89700-218",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Cartão, Pix ou Boleto",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")

    # Act
    visit root_path
    click_on "Entrar / Cadastrar"

    fill_in "E-mail",	with: "moisesalmeida@gmail.com"
    fill_in "Senha",	with: "110302"
    within ".actions" do
      click_on "Entrar"
    end

    click_on "Minha pousada"
    click_on "Editar pousada"

    fill_in 'Endereço', with: 'Rua Alemedo, 89'
    fill_in 'Bairro', with: 'João Pessoa'
    fill_in 'Estado', with: 'Sergipe'
    
    uncheck "Ativo"

    click_on "Salvar"


    # Assert
    expect(page).to have_content 'Pousada atualizado com sucesso'  
    expect(page).to have_content 'Rua Alemedo, 89'
    expect(page).to have_content 'João Pessoa'
    expect(page).to have_content 'Sergipe'

  end
  
end