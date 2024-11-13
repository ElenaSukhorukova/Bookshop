require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:inv_pass_user) do
    email =  Faker::Internet.email

    User.new(email: email, password: email)
  end

  let(:inv_emails) {
    ['string', 'https://example.com', 'wrong@email', 'wrongemail.com']
  }

  it 'checks validation' do
    expect(user).to be_valid
  end

  it 'checks invalidation of password' do
    expect(inv_pass_user.invalid?).to be_truthy

    error = I18n.t('activerecord.errors.models.user.attributes.password.exclusion')
    expect(inv_pass_user.errors.full_messages.first).to match error
  end

  it 'checks invalidation of email' do
    password = Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true)

    inv_emails.each do |inv_email|
      inv_email_user = User.new(email: inv_email, password: password)
      expect(inv_email_user.invalid?).to be_truthy
    end
  end
end
