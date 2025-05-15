require 'rails_helper'

RSpec.describe DishesController, type: :controller do
  include Devise::Test::ControllerHelpers   # <<<<<<--- Ajoute cette ligne

  describe "GET #index" do
    it "assigns @dishes" do
      dish = Dish.create!(title: "Test Dish", description: "Desc", price: 10.0, image_url: "url.jpg")
      get :index
      expect(assigns(:dishes)).to eq([dish])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
