require 'rails_helper'

describe 'User search guesthouse' do
  it 'by name ' do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
    user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00", available: false)
    
    user_1 = User.create!(email: "joazinho@gmail.com", password: "457321", role: User::TYPE_OWNER)
    user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Sergipe", city: "Aracaju", cep: "CEP da Pousada",
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
    fill_in "query",	with: "Pousada Recanto"
    click_on "Buscar"

    # Assert
    expect(page).to have_content("Resultados da busca para 'Pousada Recanto'")
    expect(page).to have_content("Quantidade de pousadas encontradas: 1")
    expect(page).to have_content('Pousada Recanto')
    
  end

  it 'by district ' do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
    user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00", available: false)
    
    user_1 = User.create!(email: "joazinho@gmail.com", password: "457321", role: User::TYPE_OWNER)
    user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Sergipe", city: "Aracaju", cep: "CEP da Pousada",
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
    fill_in "query",	with: "Veneza"
    click_on "Buscar"

    # Assert
    expect(page).to have_content("Resultados da busca para 'Veneza'")
    expect(page).to have_content("Quantidade de pousadas encontradas: 3")
    expect(page).not_to have_content('Pousada Renascer')
    
  end

  it 'by city ' do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
    user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00", available: false)
    
    user_1 = User.create!(email: "joazinho@gmail.com", password: "457321", role: User::TYPE_OWNER)
    user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Sergipe", city: "Aracaju", cep: "CEP da Pousada",
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
    fill_in "query",	with: "São Paulo"
    click_on "Buscar"

    # Assert
    expect(page).to have_content("Resultados da busca para 'São Paulo'")
    expect(page).to have_content("Quantidade de pousadas encontradas: 2")
    expect(page).not_to have_content('Pousada Renascer')
    expect(page).not_to have_content('Pousada Repouso')
    
  end

  it "when can't find a guesthouse " do
    # Arrange
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
    user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00", available: false)
    
    user_1 = User.create!(email: "joazinho@gmail.com", password: "457321", role: User::TYPE_OWNER)
    user_1.create_guesthouse!(name: "Pousada Repouso", legal_name: "Feliz Company",
                                  cnpj: "12345678901234", phone: "79 8821-4561",
                                  email: "seu@email.com", address: "Rua João Batista, 472", district: "Veneza",
                                  state: "Sergipe", city: "Aracaju", cep: "CEP da Pousada",
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
    fill_in "query",	with: "qualquer coisa"
    click_on "Buscar"

    # Assert
    expect(page).not_to have_content("Resultados da busca para 'São Paulo'")
    expect(page).not_to have_content("Quantidade de pousadas encontradas: 2")
    expect(page).not_to have_content('Pousada Renascer')
    expect(page).not_to have_content('Pousada Repouso')
    expect(page).not_to have_content('Pousada Recanto')
    expect(page).not_to have_content('Pousada Sol nascente')
    expect(page).to have_content('Nenhuma pousada encontrada para o termo "qualquer coisa"')
    
  end
end