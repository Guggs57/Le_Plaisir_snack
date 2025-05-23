class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy add_to_cart]

  # GET /carts/1
  def show
    # @cart déjà défini dans set_cart
    @cart_dishes = @cart ? @cart.cart_dishes.includes(:dish) : []
  end

  # POST /carts/add_to_cart
  def add_to_cart
    @cart ||= current_user.create_cart

    @dish = Dish.find(params[:dish_id])

    removed_ingredients = params[:removed_ingredients] || []
    removed_sauces = params[:removed_sauces] || []

    menu_option = params[:menu_option] == "1"

    Rails.logger.debug "PARAMS menu_option: #{params[:menu_option].inspect} => #{menu_option.inspect}"

    # Trouver un CartDish existant avec même plat, mêmes options et personnalisations
    @cart_dish = @cart.cart_dishes.find do |cd|
      cd.dish_id == @dish.id &&
      (cd.ingredients || []).sort == removed_ingredients.sort &&
      (cd.sauces || []).sort == removed_sauces.sort &&
      cd.menu_option == menu_option
    end

    if @cart_dish
      @cart_dish.quantity += 1
    else
      @cart_dish = @cart.cart_dishes.new(
        dish: @dish,
        quantity: 1,
        ingredients: removed_ingredients,
        sauces: removed_sauces,
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

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      redirect_to @cart, notice: "Panier mis à jour avec succès.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy!
    redirect_to carts_path, notice: "Panier supprimé avec succès.", status: :see_other
  end

  private

  def set_cart
    @cart = current_user&.cart || current_user&.create_cart
  end

  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
