require 'rails_helper'

describe 'Owner view guesthouse by city' do
  it 'and see all the guesthouses in the city of São Paulo' do
    # Arrange
    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu01@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00", available: false)
    
    user_1 = Owner.create!(email: "joazinho@gmail.com", password: "457321")
    user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "12215678901234", phone: "79 8821-4561",
                                  email: "seu02@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Sergipe", city: "Aracaju", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    
    
    user_2 = Owner.create!(email: "marcos@gmail.com", password: "109386")
    user_2.create_guesthouse!(name: "Pousada Recanto", legal_name: "Feliz Company",
                                  cnpj: "12349678901234", phone: "79 8821-4561",
                                  email: "seu03@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "São Paulo", city: "São Paulo", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")

    user_3 = Owner.create!(email: "fernando@gmail.com", password: "3780109")
    user_3.create_guesthouse!(name: "Pousada Sol nascente", legal_name: "Feliz Company",
                                  cnpj: "123456732901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "São Paulo", city: "São Paulo", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    # Act
    visit(root_path)
    select "São Paulo", from: "Cidades:"
    click_on "Filtrar"

    # Assert
    expect(page).to have_select('city', selected: 'São Paulo')
    expect(page).to have_content("Pousadas em São Paulo")
    expect(page).to have_content('Pousada Recanto')
    expect(page).to have_content('Pousada Sol nascente')
    expect(page).not_to have_content('Pousada Renascer')
    expect(page).not_to have_content('Pousada Repouso')
    
  end
end