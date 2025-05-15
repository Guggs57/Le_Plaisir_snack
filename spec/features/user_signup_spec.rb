require 'rails_helper'

RSpec.describe "User signup", type: :feature do
  it "fails to sign up if password confirmation doesn't match" do
  visit new_user_registration_path

  fill_in "user_email", with: "testuser2@example.com"
  fill_in "user_password", with: "password123"
  fill_in "user_password_confirmation", with: "wrongconfirmation"

  click_button "Sign up"

  expect(page).to have_content(/Password confirmation.*doesn't match/)
end

  it "fails to sign up if password confirmation doesn't match" do
    visit new_user_registration_path

    fill_in "user_email", with: "testuser2@example.com"
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "wrongconfirmation"

    click_button "Sign up"

    expect(page).to have_content(/Password confirmation.*doesn't match/i)

  end
end
