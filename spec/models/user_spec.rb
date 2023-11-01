require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    context "presence" do
      it "false when E-mail is empty" do
        # Arrange
        user = User.new(email: "", password: "324167mo", role: User::TYPE_OWNER)
        # Act
        result = user.valid?
  
        # Assert
        expect(result).to eq false 
      end
  
      it "false when password is empty" do
        # Arrange
        user = User.new(email: "moisesalmeida@gmail.com", password: "", role: User::TYPE_OWNER)
        # Act
        result = user.valid?
  
        # Assert
        expect(result).to eq false 
      end
    end

    context "uniqueness" do
      it "false when E-mail is already in use" do
        # Arrange
        user = User.create(email: "moisesalmeida@gmail.com", password: "5678346", role: User::TYPE_OWNER)
        second_user = User.new(email: "moisesalmeida@gmail.com", password: "23768m2", role: User::TYPE_OWNER)
        # Act
        result = second_user.valid?

        # Assert
        expect(result).to eq false  
      end
      
    end
  end

  describe "user is owner or customer" do
    it "when user is owner" do
      # Arrange
      user_owner = User.create!(email: "moisesalmeida@gmail.com", password: "5678346", role: User::TYPE_OWNER)
      user_customer = User.create!(email: "Luisricardo@gmail.com", password: "673524", role: User::TYPE_CUSTOMER)

      # Act
      result_owner = user_owner.owner?
      result_customer = user_customer.owner?

      # Assert
      expect(result_owner).to eq true 
      expect(result_customer).to eq false 
    end
    
    it "when user is customer" do
      # Arrange
      user_owner = User.create!(email: "moisesalmeida@gmail.com", password: "5678346", role: User::TYPE_OWNER)
      user_customer = User.create!(email: "Luisricardo@gmail.com", password: "673524", role: User::TYPE_CUSTOMER)

      # Act
      result_owner = user_owner.customer?
      result_customer = user_customer.customer?

      # Assert
      expect(result_owner).to eq false 
      expect(result_customer).to eq true 
    end
  end
  
end
