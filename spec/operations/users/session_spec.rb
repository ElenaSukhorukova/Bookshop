require 'rails_helper'

RSpec.describe Users::Session do
  include_context 'when activated user is present'

  let(:params) do |ex|
    email = ex.metadata[:email] || user.email
    password = ex.metadata[:password] || user.email

    {
      params: {
        email: email,
        password: password,
        remember_me: '1'
      }
    }
  end

  describe 'success pocess' do
    before do
      allow(User).to receive(:find_by).with(email: params.dig(:params, :email)).and_return(user)
      allow(user).to receive(:authenticate).and_return(true)
    end

    it 'creates new session successfully' do
      operation = described_class.call(params)

      expect(operation.session.present?).to be(true)
    end
  end

  describe 'validations' do
    it 'validates blank params' do
      operation = described_class.call({})

      expect(operation.errors.full_message).to include(I18n.t('api.v1.users.sessions.errors.blank_params'))
    end

    it 'validates blank user', email: 'scott@pouros-beahan.example' do
      operation = described_class.call(params)

      expect(operation.errors.full_message).to include(I18n.t('api.v1.users.sessions.errors.invalid_password_or_email'))
    end

    it 'validates wrong password', password: 'Ol12&*ola19' do
      operation = described_class.call(params)

      expect(operation.errors.full_message).to include(I18n.t('api.v1.users.sessions.errors.invalid_password_or_email'))
    end

    describe 'unactivated_user' do
      before do
        user.update(activated: false)
      end

      it 'validates activated user' do
        operation = described_class.call(params)

        expect(operation.errors.full_message).to include(I18n.t('api.v1.users.sessions.errors.unactivated_account'))
      end
    end
  end
end
