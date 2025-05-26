RailsAdmin.config do |config|
  config.asset_source = :sprockets

  # ... tes autres configs ...

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.model 'Dish' do
    # Ne pas afficher la méthode ingredients (qui n'est pas une association ActiveRecord)
    exclude_fields :ingredients

    # Champ virtuel affichant la liste des ingrédients par défaut
    field :default_ingredients do
      label 'Ingrédients par défaut'
      pretty_value do
        bindings[:object].ingredients.join(', ')
      end
      read_only true
    end
  end
end
