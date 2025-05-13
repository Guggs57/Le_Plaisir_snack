# db/seeds.rb

# Effacer les anciens articles avant de les recréer
Dish.destroy_all

# Générer 20 articles aléatoires
20.times do |i|
  Dish.create!(
    title: "Plat ##{i + 1}",
    description: "Description du plat ##{i + 1}. Un plat délicieux avec des ingrédients de qualité.",
    price: rand(10..30).to_d,  # Génère un prix entre 10 et 30
    image_url: "https://source.unsplash.com/200x200/?food,#{rand(1..100)}"  # Utilisation d'une image aléatoire de Unsplash
  )
end

puts "20 plats créés avec succès !"
