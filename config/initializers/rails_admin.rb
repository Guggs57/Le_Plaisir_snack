RailsAdmin.config do |config|
  config.asset_source = :sprockets

  # Authentification/autorisation si nécessaire ici (Devise, Pundit, etc.)

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

  config.model "Dish" do
    # ⚠️ On exclut l'association ActiveRecord ingredients de l'affichage (pas utilisée ici)
    exclude_fields :ingredients

    # ✅ Champ virtuel pour afficher les ingrédients par défaut (définis dans le modèle)
    field :default_ingredients do
      label "Ingrédients par défaut"
      read_only true

      # 👇 On cache ce champ dans l'action "delete" pour éviter les erreurs de rendu
      visible do
        bindings[:controller].action_name != "delete"
      end
    end
  end
end
