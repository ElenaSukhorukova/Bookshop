require 'rails_helper'

RSpec.describe Users::Updation do
  include_context 'when activated user is present'
  include_context 'when it needs an email and password'

  let(:params) do |ex|
    user_email = ex.metadata[:invalid_email] ? email : user.email
    user_password =
      if ex.metadata[:invalid_password]
        '123456789'
      else
        ex.metadata[:pass_eq_email] ? user.email : password
      end

    confirm_pass = ex.metadata[:invalid_confirm_password] ? user.password : password

    {
      params: {
        email: user_email,
        password: user_password,
        password_confirmation: confirm_pass,
        id: token
      }
    }
  end

  let(:token) do
    'eyJfcmFpbHMiOnsiZGF0YSI6WzE4LCJHbFdZZ1dObC91Il0sImV'\
    '4cCI6IjIwMjQtMTItMTVUMDc6NDk6MTYuNDcyWiIsInB1ciI6IlV'\
    'zZXJcbnJlc2V0X3Rva2VuXG45MDAifX0=--46ae1ac6cb5297cbf'\
    'd3e04a2f511c2de8081b70f'
  end

  describe 'success pocess' do
    before do
      allow(User).to receive(:find_by).with(email: params.dig(:params, :email)).and_return(user)
      allow(user).to receive(:authenticated?).with(:reset, token).and_return(true)
    end

    it 'creates new session successfully' do
      operation = described_class.call(params)

      expect(operation.success?).to be(true)
    end
  end

  describe 'validations' do
    it 'validates blank params' do
      operation = described_class.call({})

      expect(operation.errors.full_message).to include(I18n.t('errors.blank_params'))
    end

    it 'validates an email', invalid_email: true do
      operation = described_class.call(params)

      expect(operation.errors.full_message).to include(I18n.t('errors.invalid_params'))
    end

    it 'validates a wrong password', invalid_password: true do
      operation = described_class.call(params)

      expect(operation.errors.full_message).to include(I18n.t('dry_validation.errors.format'))
    end

    it 'validates password_similarity', invalid_confirm_password: true do
      operation = described_class.call(params)

      expect(operation.errors.full_message).to include(I18n.t('dry_validation.errors.password_similarity'))
    end

    it 'validates password_exclusion', pass_eq_email: true do
      operation = described_class.call(params)

      expect(operation.errors.full_message).to include(I18n.t('dry_validation.errors.password_exclusion'))
    end

    describe 'invalid_token' do
      it 'validates activated user' do
        operation = described_class.call(params)

        expect(operation.errors.full_message).to include(I18n.t('errors.invalid_token'))
      end
    end
  end
end
