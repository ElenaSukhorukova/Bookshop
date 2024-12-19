require 'rails_helper'

RSpec.describe Users::PasswordReset do
  include_context 'when it needs an email and password'
  include_context 'when activated user is present'

  let(:params) do |ex|
    user_email = ex.metadata[:wrong_email] ? email : user.email

    {
      params: {
        email: user_email
      }
    }
  end

  describe '#call' do
    it 'creates reset_token successfully' do
      described_class.call(params)

      expect(user.reload.reset_digest.present?).to be(true)
    end

    it 'validates an email', wrong_email: true do
      operation = described_class.call(params)

      expect(operation.errors.full_message).to include(I18n.t('errors.invalid_email'))
    end

    it 'validates blank params' do
      operation = described_class.call({})

      expect(operation.errors.full_message).to include(I18n.t('errors.blank_params'))
    end

    describe 'unactivated_user' do
      before do
        user.update(activated: false)
      end

      it 'validates activated user' do
        operation = described_class.call(params)

        expect(operation.errors.full_message).to include(I18n.t('errors.unactivated_account'))
      end
    end
  end
end
