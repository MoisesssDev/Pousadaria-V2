require 'rails_helper'

describe 'User view guesthouses details' do
  it 'and see all fields' do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
    guesthouse = Guesthouse.new(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "João Pessoa", cep: "89700-218",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Cartão, Pix ou Boleto",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")
    guesthouse.user = user
    guesthouse.save
    user.guesthouse_id = guesthouse.id

    # Act
    visit root_path
    click_on "Pousada Renascer"

    # Assert
    expect(page).to have_content('Pousada Renascer')
    expect(page).to have_content('Razão Social da Pousada')
    expect(page).to have_content('12345678901234')
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
  
end