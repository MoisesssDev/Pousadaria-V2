
owner1 = Owner.create!(
  email: "john.doe@example.com",
  password: "secure_password_123"
)

guesthouse1 = owner1.create_guesthouse!(
  name: "Sunset Inn",
  legal_name: "Sunset Inn Ltd.",
  cnpj: "98765432101234",
  phone: "123-456-7890",
  email: "info@sunsetinn.com",
  address: "123 Main St",
  district: "Downtown",
  state: "California",
  city: "Los Angeles",
  cep: "90001",
  description: "A cozy inn with a beautiful view of the sunset.",
  accepted_payment_methods: "Credit card, cash",
  accepts_pets: true,
  policies: "No smoking allowed. Pets allowed in designated rooms.",
  check_in_time: "12:00:00",
  check_out_time: "14:00:00"
)

room1 = guesthouse1.rooms.create!(
  name: "Deluxe Suite",
  description: "Spacious suite with a comfortable king-size bed.",
  dimension: 40,
  max_occupancy: 2,
  daily_rate: 200.00,
  has_private_bathroom: true,
  has_balcony: true,
  has_air_conditioning: true,
  has_tv: true,
  has_wardrobe: true,
  is_accessible: true,
  has_cofre: true,
  available: true
)


owner2 = Owner.create!(
  email: "jane.smith@example.com",
  password: "strong_password_456"
)

guesthouse2 = owner2.create_guesthouse!(
  name: "Mountain Retreat",
  legal_name: "Mountain Retreat Hospitality",
  cnpj: "87654321098765",
  phone: "987-654-3210",
  email: "info@mountainretreat.com",
  address: "456 Mountain View Rd",
  district: "Hills",
  state: "Colorado",
  city: "Denver",
  cep: "80001",
  description: "Experience serenity surrounded by nature.",
  accepted_payment_methods: "Credit card",
  accepts_pets: false,
  policies: "No smoking. Quiet hours from 10:00 PM to 6:00 AM.",
  check_in_time: "14:00:00",
  check_out_time: "12:00:00"
)

room2 = guesthouse2.rooms.create!(
  name: "Standard Room",
  description: "Comfortable room with a beautiful view of the mountains.",
  dimension: 30,
  max_occupancy: 2,
  daily_rate: 150.00,
  has_private_bathroom: true,
  has_balcony: false,
  has_air_conditioning: true,
  has_tv: true,
  has_wardrobe: true,
  is_accessible: true,
  has_cofre: false,
  available: true
)

owner3 = Owner.create!(
  email: "sam.jones@example.com",
  password: "password123"
)

guesthouse3 = owner3.create_guesthouse!(
  name: "Seaside Retreat",
  legal_name: "Seaside Retreat Resorts",
  cnpj: "76543210987654",
  phone: "567-890-1234",
  email: "info@seasideretreat.com",
  address: "789 Ocean Blvd",
  district: "Beachside",
  state: "Florida",
  city: "Miami",
  cep: "33101",
  description: "Relax by the beach in our luxurious seaside resort.",
  accepted_payment_methods: "Credit card, PayPal",
  accepts_pets: true,
  policies: "Beach towels provided. No outside food in rooms.",
  check_in_time: "15:00:00",
  check_out_time: "11:00:00"
)

room3 = guesthouse3.rooms.create!(
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
