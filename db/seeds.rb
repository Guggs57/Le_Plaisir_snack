require 'faker'

puts "🧹 Nettoyage..."
Dish.destroy_all

puts "🍔 Création de plats..."

10.times do
  Dish.create!(
    title: Faker::Food.dish,
    description: Faker::Food.description,
    price: rand(5.0..15.0).round(2),
    image_url: "https://source.unsplash.com/600x400/?food,#{rand(1000)}"
  )
end

puts "✅ Plats créés !"
