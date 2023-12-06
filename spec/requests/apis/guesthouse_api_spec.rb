require "rails_helper"

describe "Pousadaria API", type: :request do
  context "GET /api/v1/guesthouses/1" do

    it "success" do
      #Arrange
      user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
      user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu01@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00")

      #Act
      get "/api/v1/guesthouses/#{user.guesthouse.id}"

      #Assert
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include("application/json")

      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to include("Pousada Renascer")
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
    end

    it "not found" do
      #Arrange
      
      #Act
      get "/api/v1/guesthouses/9021873"

      #Assert
      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to include("application/json")
    end

  end

end
