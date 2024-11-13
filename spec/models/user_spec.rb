require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:inv_user) { create(:user, :inv_user) }

  it 'checks validation' do
    expect(user).to be_valid
  end

  it 'checks validation' do
    expect(user).to be_valid
  end
end
