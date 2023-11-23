require 'rails_helper'

describe "user client is authenticated" do
  it "with sucessfully" do
    # Arrange
    Client.create!(email: "moises@teste.com", password: "123456mo", full_name: "Moises Almeida Leite", cpf: "09032145622")
    # Act
    visit root_path
    click_on "Entrar / Cadastrar"
    click_on "aqui"
    fill_in "E-mail",	with: "moises@teste.com"
    fill_in "Senha",	with: "123456mo" 

    within ".actions" do
      click_on "Entrar"
    end

    # Assert
    expect(page).not_to have_content "Entrar"
    expect(page).to have_button "Sair"

    expect(page).to have_content "Login efetuado com sucesso"
  end
  
  it "and log out" do
    # Arrange
    Client.create!(email: "moises@teste.com", password: "123456mo", full_name: "Moises Almeida Leite", cpf: "09032145622")
    # Act
    visit root_path
    click_on "Entrar / Cadastrar"
    click_on "aqui"
    fill_in "E-mail",	with: "moises@teste.com" 
    fill_in "Senha",	with: "123456mo"

    within ".actions" do
      click_on "Entrar"
    end
    click_on "Sair"
    

    # Assert
    expect(page).to have_content("Logout efetuado com sucesso.")

    expect(page).to have_content("Entrar / Cadastrar")
    expect(page).not_to have_link("Sair")
  end

end
