require 'faker'

puts "🧹 Nettoyage..."
Dish.destroy_all
Ingredient.destroy_all
User.destroy_all
Cart.destroy_all

puts "🍔 Création de 20 plats..."

20.times do
  Dish.create!(
    title: Faker::Food.dish,
    description: Faker::Food.description,
    price: rand(5.0..15.0).round(2),
    image_url: "https://source.unsplash.com/600x400/?food,#{rand(1000)}"
  )
end

puts "✅ Plats créés !"

puts "🌿 Création des ingrédients..."

ingredients_list = %w[
  salade tomate oignon fromage poulet bacon avocat cornichon concombre
  carotte poivron champignon ketchup mayonnaise harissa samouraï
]

ingredients_list.each do |name|
  Ingredient.create!(name: name)
end

puts "✅ Ingrédients créés !"

puts "👤 Création d'un utilisateur de test..."

user = User.create!(
  email: "test@example.com",
  password: "password",
  password_confirmation: "password"
)

puts "✅ Utilisateur créé : #{user.email}"

puts "🛒 Création du panier pour l'utilisateur..."

Cart.create!(user: user)

puts "✅ Panier créé !"

puts "🌟 Seed terminée !"
