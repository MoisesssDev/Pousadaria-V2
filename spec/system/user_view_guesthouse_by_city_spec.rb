require 'rails_helper'

describe 'User view guesthouse by city' do
  it 'and see all the guesthouses in the city of São Paulo' do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
    user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00", available: false)
    
    user_1 = User.create!(email: "joazinho@gmail.com", password: "457321", role: User::TYPE_OWNER)
    user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    
    
    user_2 = User.create!(email: "marcos@gmail.com", password: "109386", role: User::TYPE_OWNER)
    user_2.create_guesthouse!(name: "Pousada Recanto", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "São Paulo", city: "São Paulo", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")

    user_3 = User.create!(email: "fernando@gmail.com", password: "3780109", role: User::TYPE_OWNER)
    user_3.create_guesthouse!(name: "Pousada Sol nascente", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "São Paulo", city: "São Paulo", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    # Act
    visit(root_path)
    select "São Paulo", from: "Selecione uma cidade"
    click_on "Pesquisar"

    # Assert
    expect(page).to have_content("Pousadas em São Paulo")
    expect(page).to have_content('Pousada Recanto')
    expect(page).to have_content('Pousada Sol nascente')
    expect(page).not_to have_content('Pousada Renascer')
    expect(page).not_to have_content('Pousada Repouso')

  end
end