require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'new@email.com', password: 'Pnme!&jj$nnO') }

  it 'checks validation' do
    expect(subject).to be_valid
  end
end
