require 'rails_helper'

describe 'User visit home page' do
  it 'and see name app' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Pousadaria')
  end

  it 'and see guesthouses' do
    # Arrange
    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    guesthouse = user.build_guesthouse(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "129095678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00")
    guesthouse.save

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Pousada Renascer')
    expect(page).to have_content('79 98837-7894')
    expect(page).to have_content('Rua Alemedo, 54')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('Descrição da Pousada')
  end

  it 'and view recent guesthouses' do
    # Arrange
    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    guesthouse = user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "52345678901234", phone: "79 98837-7894",
                                   email: "seu01@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00")
    
    user_1 = Owner.create!(email: "joazinho@gmail.com", password: "457321")
    guesthouse_1 = user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content("Recentes")

    expect(page).to have_content('Pousada Renascer')
    expect(page).to have_content('79 98837-7894')
    expect(page).to have_content('Rua Alemedo, 54')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('Descrição da Pousada')

    expect(page).to have_content('Pousada Repouso')
    expect(page).to have_content('79 8821-4561')
    expect(page).to have_content('Rua João Batista, 472')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('Pousada em frente ao mar')
  end

  it 'and view all the other guesthouses' do
    # Arrange
    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "126745678901234", phone: "79 98837-7894",
                                   email: "seu@email01.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00")
    
    user_1 = Owner.create!(email: "joazinho@gmail.com", password: "457321")
    user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "4345678901234", phone: "79 8821-4561",
                                  email: "seu02@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    
    
    user_2 = Owner.create!(email: "marcos@gmail.com", password: "109386")
    user_2.create_guesthouse!(name: "Pousada Recanto", legal_name: "Feliz Company",
                                  cnpj: "23345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")

    user_3 = Owner.create!(email: "fernando@gmail.com", password: "3780109")
    user_3.create_guesthouse!(name: "Pousada Sol nascente", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email03.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content("Recentes")

    expect(page).to have_content("Todas as Pousadas")

    expect(page).to have_content('Pousada Renascer')

    expect(page).to have_content('Pousada Repouso')

    expect(page).to have_content('Pousada Recanto')

    expect(page).to have_content('Pousada Sol nascente')

  end
  
  it 'and not see unavailable guesthouses' do
    # Arrange
    user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
    user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12315678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00", available: false)
    
    user_1 = Owner.create!(email: "joazinho@gmail.com", password: "457321")
    user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "123456438901234", phone: "79 8821-4561",
                                  email: "seu01@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    
    
    user_2 = Owner.create!(email: "marcos@gmail.com", password: "109386")
    user_2.create_guesthouse!(name: "Pousada Recanto", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu02@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")

    user_3 = Owner.create!(email: "fernando@gmail.com", password: "3780109")
    user_3.create_guesthouse!(name: "Pousada Sol nascente", legal_name: "Feliz Company",
                                  cnpj: "12345778901234", phone: "79 8821-4561",
                                  email: "seu03@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                  description: "Pousada em frente ao mar", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content("Recentes")

    expect(page).to have_content("Todas as Pousadas")

    expect(page).not_to have_content('Pousada Renascer')

    expect(page).to have_content('Pousada Repouso')

    expect(page).to have_content('Pousada Recanto')

    expect(page).to have_content('Pousada Sol nascente')

  end
end