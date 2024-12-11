require 'rails_helper'

RSpec.describe Users::Creation do
  let(:params) do |ex|
    email = ex.metadata[:email] || 'wen@morar.example'
    password = ex.metadata[:password] || '9X%14*EuSLQ'
    password_confirmation = ex.metadata[:password_confirmation] || password

    {
      params: {
        email: email,
        password: password,
        password_confirmation: password_confirmation,
        role: 'customer'
      }
    }
  end

  describe '#call' do
    it 'creates new user successfully' do
      described_class.call(params)

      user = User.find_by(email: params.dig(:params, :email))

      expect(user.present?).to be(true)
    end

    it 'validates email format', email: 'wenmorar.example' do
      user_creation = described_class.call(params)

      user = User.find_by(email: params.dig(:params, :email))

      expect(user.present?).to be(false)
      expect(user_creation.errors.full_message).to include(I18n.t('dry_validation.errors.user.format'))
    end

    it 'validates password format', password: '12345678' do
      user_creation = described_class.call(params)

      user = User.find_by(email: params.dig(:params, :email))

      expect(user.present?).to be(false)
      expect(user_creation.errors.full_message).to include(I18n.t('dry_validation.errors.user.format'))
    end

    it 'validates password exclusion with email', password: 'wen@morar.example' do
      user_creation = described_class.call(params)

      user = User.find_by(email: params.dig(:params, :email))

      expect(user.present?).to be(false)
      expect(user_creation.errors.full_message).to include(I18n.t('dry_validation.errors.user.password_exclusion'))
    end

    it 'validates password exclusion with email', password_confirmation: 'wen@morar.example' do
      user_creation = described_class.call(params)

      user = User.find_by(email: params.dig(:params, :email))

      expect(user.present?).to be(false)
      expect(user_creation.errors.full_message).to include(I18n.t('dry_validation.errors.user.password_similarity'))
    end

    it 'validates blank params' do
      user_creation = described_class.call({})

      expect(user_creation.errors.full_message).to include(Users::Creation::ABSENT_PARAMS)
    end
  end
end
