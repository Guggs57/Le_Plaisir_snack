class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @orders = @user.orders  # Charger toutes les commandes de l'utilisateur
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_profile_path, notice: 'Profil mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: 'Votre compte a été supprimé.'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
