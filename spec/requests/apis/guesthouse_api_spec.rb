require "rails_helper"

describe "Pousadaria API", type: :request do
  context "GET /api/v1/guesthouses/1" do

    it "success" do
      #Arrange
      user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
      guesthouse = user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                   cnpj: "12345678901234", phone: "79 98837-7894",
                                   email: "seu01@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                   state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                   description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                   accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                   check_in_time: "10:00:00", check_out_time: "14:00:00")
      room = guesthouse.rooms.create!(
        name: "Ocean View Suite",
        description: "Spacious suite with a breathtaking view of the ocean.",
        dimension: 45,
        max_occupancy: 2,
        daily_rate: 250.00,
        has_private_bathroom: true,
        has_balcony: true,
        has_air_conditioning: true,
        has_tv: true,
        has_wardrobe: true,
        is_accessible: false,
        has_cofre: true,
        available: true
      )
      #Act
      get "/api/v1/guesthouses/#{user.guesthouse.id}"

      #Assert
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include("application/json")

      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to include("Pousada Renascer")
      expect(json_response["rooms"][0]["name"]).to include("Ocean View Suite")

      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
      expect(json_response.keys).not_to include("cnpj")
      expect(json_response.keys).not_to include("legal_name")
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

  context "GET /api/v1/guesthouses" do
      
      it "list all guesthouses and order by name" do
        #Arrange
        user = Owner.create!(email: "moisesalmeida@gmail.com", password: "110302")
        user.create_guesthouse!(name: "Pousada Renascer", legal_name: "Razão Social da Pousada",
                                     cnpj: "12345678901234", phone: "79 98837-7894",
                                     email: "seu01@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                     state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                     description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                     accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                     check_in_time: "10:00:00", check_out_time: "14:00:00")

        user2 = Owner.create!(email: "fernando@gmail.com", password: "110302")
        user2.create_guesthouse!(name: "Pousada Azull", legal_name: "Razão Social da Pousada",
                                  cnpj: "1298078901234", phone: "79 98837-7894",
                                  email: "seu02@email.com", address: "Rua Alemedo, 54", district: "Cocora",
                                  state: "Rio de Janeiro", city: "Rio de Janeiro", cep: "CEP da Pousada",
                                  description: "Descrição da Pousada", accepted_payment_methods: "Métodos de pagamento aceitos",
                                  accepts_pets: true, policies: "Políticas de Uso da Pousada", 
                                  check_in_time: "10:00:00", check_out_time: "14:00:00")
        #Act
        get "/api/v1/guesthouses"

        #Assert
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include("application/json")

        json_response = JSON.parse(response.body)

        expect(json_response[0]["name"]).to include("Pousada Azull")
        expect(json_response[1]["name"]).to include("Pousada Renascer")

        expect(json_response[0].keys).not_to include("created_at")
        expect(json_response[0].keys).not_to include("updated_at")
        expect(json_response[0].keys).not_to include("cnpj")
        expect(json_response[0].keys).not_to include("legal_name")

        expect(json_response[1].keys).not_to include("created_at")
        expect(json_response[1].keys).not_to include("updated_at")
        expect(json_response[1].keys).not_to include("cnpj")
        expect(json_response[1].keys).not_to include("legal_name")

        expect(json_response.length).to eq(2) 
      end

      it "no guesthouses" do
        #Arrange
        
        #Act
        get "/api/v1/guesthouses"

        #Assert
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to include("application/json")

        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to include("Nenhuma pousada encontrada")
      end
  end

end
