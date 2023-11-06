require 'rails_helper'

describe 'authenticated user(owner) registers room' do

  context "by login" do
    it 'and see the edit form' do
      # Arrange
      user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
      guesthouse = user.build_guesthouse(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                     cnpj: "12345678901234", phone: "79 98837-7894",
                                     email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                     state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                     description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                     accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")
      guesthouse.save
  
      # Act
      visit root_path
      click_on "Entrar / Cadastrar"
      fill_in "E-mail",	with: "moisesalmeida@gmail.com"
      fill_in "Senha",	with: "110302"
      within "form" do
        click_on "Entrar"
      end
      click_on "Minha pousada"
      click_on "Adicionar quarto"

  
      # Assert
      expect(page).to have_field('Nome')
      expect(page).to have_field('Descrição')
      expect(page).to have_field('Área')
      expect(page).to have_field('Quantidade máxima de pessoas')
      expect(page).to have_field('Diária')
      expect(page).to have_field('Tem banheiro')
      expect(page).to have_field('Tem varanda')
      expect(page).to have_field('Tem ar-condicionado')
      expect(page).to have_field('Tem TV')
      expect(page).to have_field('Tem guarda-roupa')
      expect(page).to have_field('É acessível')
      expect(page).to have_field('Tem cofre')
      expect(page).to have_field('ativo')
    end

    it "and register with sucess" do
      # Arrange
      user = User.create!(email: "moisesalmeida@gmail.com", password: "110302", role: User::TYPE_OWNER)
      guesthouse = user.build_guesthouse(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                     cnpj: "12345678901234", phone: "79 98837-7894",
                                     email: "seu@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                     state: "Rio de Janeiro", city: "Cidade da Pousada", cep: "CEP da Pousada",
                                     description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                     accepts_pets: true, policies: "Políticas de Uso da Pousada", check_in_time: "10:00:00", check_out_time: "14:00:00")
      guesthouse.save
  
      # Act
      visit root_path
      click_on "Entrar / Cadastrar"

      fill_in "E-mail",	with: "moisesalmeida@gmail.com"
      fill_in "Senha",	with: "110302"
      within "form" do
        click_on "Entrar"
      end

      click_on "Minha pousada"
      click_on "Adicionar quarto"

      fill_in "Nome", with: "Sala de Exemplo"
      fill_in "Descrição", with: "Uma descrição de exemplo"
      fill_in "Área", with: 20
      fill_in "Quantidade máxima de pessoas", with: 2
      fill_in "Diária", with: 100.50

      check "Tem banheiro"
      check "Tem varanda"
      check "Tem ar-condicionado"
      check "Tem TV"
      check "Tem guarda-roupa"
      check "É acessível"
      check "Tem cofre"
      check "ativo"

      click_on "Salvar"

  
      # Assert
      expect(page).to have_content 'Quarto cadastrada com sucesso'
      expect(current_path).to eq guesthouse_path(guesthouse.id)
      
    end
    
  end
  
end