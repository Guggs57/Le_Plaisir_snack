class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy add_to_cart]

  # GET /carts/:id
  def show
    # Si pas de panier, renvoyer tableau vide pour la vue
    @cart_dishes = @cart ? @cart.cart_dishes.includes(:dish) : []
  end

  # POST /carts/:id/add_to_cart
  def add_to_cart
    # Création du panier si absent (normalement set_cart l’a fait)
    @cart ||= current_user.create_cart

    Rails.logger.debug "Params reçus dans add_to_cart : #{params.inspect}"

    # Chercher le plat, erreur si nil
    @dish = Dish.find(params[:dish_id])

    removed_ingredients = params[:removed_ingredients] || []
    selected_sauces = params[:selected_sauces] || []

    menu_option = params[:menu_option] == "1"

    # Trouver un cart_dish existant avec mêmes options
    @cart_dish = @cart.cart_dishes.find do |cd|
      cd.dish_id == @dish.id &&
      (cd.ingredients || []).sort == removed_ingredients.sort &&
      (cd.sauces || []).sort == selected_sauces.sort &&
      cd.menu_option == menu_option
    end

    if @cart_dish
      @cart_dish.quantity += 1
    else
      @cart_dish = @cart.cart_dishes.new(
        dish: @dish,
        quantity: 1,
        ingredients: removed_ingredients,
        sauces: selected_sauces,
        menu_option: menu_option
      )
    end

    if @cart_dish.save
      notice_msg = "#{@dish.title} ajouté au panier"
      notice_msg += menu_option ? " en menu (boisson + accompagnement)." : "."
      redirect_to cart_path(@cart), notice: notice_msg
    else
      redirect_to dish_path(@dish), alert: "Impossible d'ajouter le plat au panier."
    end
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart, notice: "Panier créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/:id
  def update
    if @cart.update(cart_params)
      redirect_to @cart, notice: "Panier mis à jour avec succès.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /carts/:id
  def destroy
    @cart.destroy!
    redirect_to carts_path, notice: "Panier supprimé avec succès.", status: :see_other
  end

  private

  def set_cart
    # Cherche le panier via params[:id] (l’ID est obligatoire sur cette route)
    @cart = current_user&.cart || current_user&.create_cart
  end

  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
