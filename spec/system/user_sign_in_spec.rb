require 'rails_helper'

describe "user is authenticated" do
  it "with sucessfully" do
    # Arrange
    Owner.create!(email: "moises@teste.com", password: "123456mo")
    # Act
    visit root_path
    click_on "Entrar"
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
    Owner.create!(email: "moises@teste.com", password: "123456mo")
    # Act
    visit root_path
    click_on "Entrar"
    fill_in "E-mail",	with: "moises@teste.com" 
    fill_in "Senha",	with: "123456mo" 

    within ".actions" do
      click_on "Entrar"
    end
    click_on "Sair"

    # Assert
    expect(page).to have_content "Entrar"  
    expect(page).not_to have_link "Sair"

    expect(page).to have_content "Logout efetuado com sucesso"  
  end

end
