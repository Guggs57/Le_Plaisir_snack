require 'rails_helper'

RSpec.describe "devise/registrations/new.html.erb", type: :view do
  before do
    # Méthodes à définir dans la vue
    view.define_singleton_method(:resource) { User.new }
    view.define_singleton_method(:resource_name) { :user }
    view.define_singleton_method(:devise_mapping) { Devise.mappings[:user] }
    assign(:minimum_password_length, 6)
  end

  it "affiche le formulaire d'inscription avec les champs essentiels" do
    render
    expect(rendered).to have_selector("form")
    expect(rendered).to have_field("user_email")
    expect(rendered).to have_field("user_password")
    expect(rendered).to have_field("user_password_confirmation")
  end
end
