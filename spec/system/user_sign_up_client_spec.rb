require 'rails_helper'

describe "user sign up client " do
  it "successfully registers a new client" do
    # Arrange
    visit root_path
    click_on "Entrar / Cadastrar"
    click_on "aqui"
    click_on "Criar conta"
    
    # Act
    fill_in "E-mail",	with: "moises@test.com"
    fill_in "Senha",	with: "password123"
    fill_in "Confirme sua senha",	with: "password123"
    fill_in "Nome completo",	with: "Moises Almeida Leite"
    fill_in "CPF",	with: "12345678901"
    click_on "Cadastrar"
    
    # Assert
    expect(page).to have_content("Boas vindas! Você criou sua conta com sucesso")
    expect(page).to have_button("Sair")
    expect(Client.last.full_name).to eq("Moises Almeida Leite")
    expect(Client.last.cpf).to eq("12345678901")

  end
  
  it "displays error messages for invalid client registration" do
    # Arrange
    visit root_path
    click_on "Entrar / Cadastrar"
    click_on "aqui"
    click_on "Criar conta"
    
    # Act
    fill_in "E-mail",	with: "invalidemail"
    fill_in "Senha",	with: "password123"
    fill_in "Nome completo",	with: ""
    fill_in "CPF",	with: "12345678901"
    click_on "Cadastrar"
    
    # Assert
    expect(page).to have_content("E-mail não é válido")
    expect(page).to have_content("Nome completo não pode ficar em branco")
    expect(page).not_to have_button("Sair")
  end
end
