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
    user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
    guesthouse = Guesthouse.new(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")
    guesthouse.user = user
    guesthouse.save
    user.guesthouse_id = guesthouse.id

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Pousada Renascer')
    expect(page).to have_content('79 98837-7894')
    expect(page).to have_content('Rua Alemedo, 54')
    expect(page).to have_content('Cocora')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('Descrição da Pousada')
  end
  
end