class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy add_to_cart]

  # Action existante : GET /carts/1
def show
  @cart = current_user.cart
  @cart_dishes = @cart ? @cart.cart_dishes : []
end

  # Action pour ajouter un plat au panier
  def add_to_cart
  @cart = current_user.cart || Cart.create(user: current_user)
  @dish = Dish.find(params[:dish_id])

  # On récupère les ingrédients cochés pour suppression (peut être nil)
  removed_ingredients = params[:removed_ingredients] || []

  # Trouver ou initialiser un CartDish avec les mêmes ingrédients retirés (personnalisation)
  @cart_dish = @cart.cart_dishes.find do |cd|
    cd.dish_id == @dish.id && (cd.ingredients || []).sort == removed_ingredients.sort
  end

  if @cart_dish
    # Si on a déjà un cart_dish avec cette personnalisation, on augmente la quantité
    @cart_dish.quantity += 1
  else
    # Sinon, on en crée un nouveau avec les ingrédients retirés
    @cart_dish = @cart.cart_dishes.new(dish: @dish, quantity: 1, ingredients: removed_ingredients)
  end

  if @cart_dish.save
    redirect_to cart_path(@cart), notice: "#{@dish.title} ajouté au panier avec vos modifications."
  else
    redirect_to dish_path(@dish), alert: "Impossible d'ajouter le plat au panier."
  end
end


  # Actions existantes : create, update, destroy
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart, notice: "Panier créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @cart.update(cart_params)
      redirect_to @cart, notice: "Panier mis à jour avec succès.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy!
    redirect_to carts_path, notice: "Panier supprimé avec succès.", status: :see_other
  end

  private

    # Méthode pour récupérer ou créer le panier de l'utilisateur
  def set_cart
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      @cart = nil
    end
  end


  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
