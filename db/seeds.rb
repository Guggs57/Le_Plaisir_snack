Dish.destroy_all

# ----- SANDWICHS -----
Dish.create!(title: "KEBAB", price: 5.5)
Dish.create!(title: "KEBAB XL", price: 8)
Dish.create!(title: "DEMI KEBAB", price: 4)
Dish.create!(title: "MIX", price: 6)
Dish.create!(title: "POULET", price: 6)
Dish.create!(title: "SUCUK", price: 5)
Dish.create!(title: "FALAFEL", price: 5)
Dish.create!(title: "VEGETARIEN KEBAB", price: 4.5)
Dish.create!(title: "TOASTT FROMAGE CHEESE", price: 5)
Dish.create!(title: "HAMBURGER", price: 5)
Dish.create!(title: "CHEESE", price: 5.5)
Dish.create!(title: "AMERICAN", price: 8)
Dish.create!(title: "KÖFTE", price: 5.5)

# ----- TACOS -----
Dish.create!(title: "DURUM KEBAB", price: 6)
Dish.create!(title: "DURUM POULET", price: 6)
Dish.create!(title: "LAHMACUM KEBAB", price: 6)
Dish.create!(title: "LAHMACUM POULET", price: 6)
Dish.create!(title: "TACOS 1 VIANDE", price: 5.5)
Dish.create!(title: "TACOS 2 VIANDES", price: 7)
Dish.create!(title: "TACOS 3 VIANDES", price: 8)

# ----- ASSIETTES -----
Dish.create!(title: "ASSIETTE KEBAB", price: 10)
Dish.create!(title: "ASSIETTE POULET", price: 10.5)
Dish.create!(title: "ASSIETTE KÖFTE", price: 10.5)
Dish.create!(title: "ASSIETTE SUCUK", price: 10)
Dish.create!(title: "ASSIETTE ROYALE 3 VIANDES", price: 13)
Dish.create!(title: "ASSIETTE FALAFEL", price: 9.5)
Dish.create!(title: "ASSIETTE OMELETTE", price: 9.5)
Dish.create!(title: "ASSIETTE CHEESE", price: 10.5)
Dish.create!(title: "ASSIETTE HAMBURGER", price: 10.5)
Dish.create!(title: "ESCALOPE PANÉE", price: 9.5, description: "Servie avec salades et frites")
Dish.create!(title: "ESCALOPE CRÈME CHAMPIGNONS", price: 9.5, description: "Servie avec salades et frites")
Dish.create!(title: "ESCALOPE PARMIGIANA", price: 9.5, description: "Servie avec salades et frites")

# ----- PÂTES -----
Dish.create!(title: "ARABIATA", price: 6, description: "Tomate douce, basilic")
Dish.create!(title: "BOLOGNAISE", price: 7.5, description: "Mélanges légumes de saison")
Dish.create!(title: "POULET (PÂTES)", price: 7.5, description: "Champignons, crème, poivre frais")
Dish.create!(title: "SAUMON", price: 8, description: "Crème")
Dish.create!(title: "CARBONARA", price: 7.5, description: "Jambon halal, crème")

# ----- PIDE -----
Dish.create!(title: "PIDÉ KEBAB", price: 7)
Dish.create!(title: "PIDÉ SUCUK", price: 6.5)
Dish.create!(title: "PIDÉ FROMAGE", price: 6.5)
Dish.create!(title: "PIDÉ VIANDE HACHÉE", price: 7.5)
Dish.create!(title: "CALZONE", price: 7, description: "Sauce tomate, fromage")
Dish.create!(title: "CALZONE KEBAB", price: 8, description: "Sauce tomate, kebab, fromage")

# ----- SALADES -----
Dish.create!(title: "SALADE KEBAB COMPOSÉE", price: 7, description: "Salade, olives")
Dish.create!(title: "SALADE POULET", price: 7.5, description: "Salade, oignons, tomate, concombre, chou")
Dish.create!(title: "SALADE NIZZA", price: 7.5, description: "Salade, thon, oignon, tomate, concombre, œuf")
Dish.create!(title: "SALADE DU CHEF", price: 7, description: "Salade, tomate, concombre, oignon, olive, feta, œuf")
Dish.create!(title: "SALADE KASA", price: 7, description: "Salade, œuf, jambon halal")

# ----- SPÉCIALITÉS TURQUES -----
Dish.create!(title: "SOUPE DU JOUR CHORBA", price: 4.5)
Dish.create!(title: "KARNI YARIK", price: 10.5, description: "Aubergine, viande hachée, légumes, sauce tomate")

# ----- EXTRAS -----
Dish.create!(title: "PETITE FRITE", price: 2.5)
Dish.create!(title: "GRANDE FRITE", price: 3.5)
Dish.create!(title: "PETIT BULGUR", price: 3)
Dish.create!(title: "GRAND BULGUR", price: 4)
Dish.create!(title: "SIRAGA BOREGI (6 PIÈCES)", price: 6.5)
Dish.create!(title: "TENDERS (5 PIÈCES)", price: 6.5)
Dish.create!(title: "NUGGETS (6 PIÈCES)", price: 5.5)
Dish.create!(title: "SUPPLÉMENT FROMAGE", price: 0.5)
Dish.create!(title: "SUPPLÉMENT SAUCE", price: 0.5)

puts "Seed terminée avec #{Dish.count} plats."
