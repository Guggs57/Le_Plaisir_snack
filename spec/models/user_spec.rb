require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_one(:cart).dependent(:destroy) }
  it { should have_many(:orders).dependent(:destroy) }


  describe 'callbacks' do
    it 'creates a cart after user creation' do
      user = FactoryBot.create(:user)
      expect(user.cart).to be_present
    end
  end

  it 'is valid with valid attributes' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user = FactoryBot.build(:user, password: nil)
    expect(user).not_to be_valid
  end
end
