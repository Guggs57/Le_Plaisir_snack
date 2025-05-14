class ProfilesController < ApplicationController
  before_action :authenticate_user!  # S'assurer que l'utilisateur est connecté

  def show
    @orders = current_user.orders
  end
end