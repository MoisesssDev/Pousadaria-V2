require 'rails_helper'

describe 'User visit home page' do
  it 'and see name app' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Pousadaria')
  end
  
end