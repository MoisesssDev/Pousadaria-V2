require 'rails_helper'

describe "User creates account " do
  it "from the home page" do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Senha')
    expect(page).to have_field('Tipo')
  end

  it "owner account successfully created" do
    # Arrange

    # Act
    visit root_path
    click_on "Cadastrar"
    fill_in "E-mail",	with: "moisesAlmeida@hotmail.com" 
    fill_in "Senha",	with: "32415mo"
    select "Dono de Pousada", from: "Tipo"
    click_on "Salvar"

    # Assert
    expect(page).to have_content("Conta criada com sucesso") 
    expect(page).to have_current_path(new_guesthouse_path)
    expect(User.last.role).to eq(User::TYPE_OWNER)
  end
  
  it "with incomplete data" do
    # Arrange

    # Act
    visit root_path
    click_on "Cadastrar"
    fill_in "E-mail",	with: "" 
    fill_in "Senha",	with: ""
    click_on "Salvar"

    # Assert
    expect(page).to have_content("Não foi possivel criar a conta")
    expect(page).to have_content("E-mail não pode ficar em branco")
    expect(page).to have_content("Senha não pode ficar em branco")

  end
end