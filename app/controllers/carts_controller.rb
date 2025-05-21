class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy add_to_cart]

  # Action existante : GET /carts/1
def show
  @cart = current_user.cart
  @cart_dishes = @cart ? @cart.cart_dishes : []
end

  # Action pour ajouter un plat au panier
  def add_to_cart
    @cart = current_user.cart || Cart.create(user: current_user)  # Crée le panier si aucun n'existe
    @dish = Dish.find(params[:dish_id])  # Récupérer le plat par son ID
  
  # Ajouter le plat au panier (ou augmenter la quantité)
    @cart_dish = @cart.cart_dishes.find_or_initialize_by(dish: @dish)
    @cart_dish.quantity ||= 0  # Si quantity est nil, on l'initialise à 0
    @cart_dish.quantity += 1    # On ajoute 1 à la quantité
    @cart_dish.save

  redirect_to cart_path(@cart), notice: "#{@dish.title} a été ajouté au panier."
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
