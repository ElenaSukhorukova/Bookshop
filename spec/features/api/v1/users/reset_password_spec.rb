require 'rails_helper'

RSpec.describe 'Sessions', type: :feature do
  include_context 'when activated user is present'
  include_context 'when it needs an email and password'

  let(:token) do
    'eyJfcmFpbHMiOnsiZGF0YSI6WzE4LCJHbFdZZ1dObC91Il0sImV'\
    '4cCI6IjIwMjQtMTItMTVUMDc6NDk6MTYuNDcyWiIsInB1ciI6IlV'\
    'zZXJcbnJlc2V0X3Rva2VuXG45MDAifX0=--46ae1ac6cb5297cbf'\
    'd3e04a2f511c2de8081b70f'
  end

  let(:params) do
    {
      id: token,
      locale: 'en',
      email: user.email
    }
  end

  describe 'new' do
    it 'checks an error message' do
      visit new_password_reset_path

      expect(page).to have_content I18n.t('views.password_reset.new.title')

      #   within('#new_session') do
      #     fill_in I18n.t('views.forms.email'), with: email
      #     fill_in I18n.t('views.forms.password'), with: password
      #     check I18n.t('views.forms.remember_me')
      #   end

      #   click_button 'Create Session'

      #   expect(page).to have_content I18n.t('api.v1.users.sessions.errors.invalid_password_or_email')
    end

    # it 'checks redirection and flash' do
    #   visit signin_path(locale: 'en')

    #   within('#new_session') do
    #     fill_in I18n.t('views.forms.email'), with: user.email
    #     fill_in I18n.t('views.forms.password'), with: user.password
    #     check I18n.t('views.forms.remember_me')
    #   end

    #   click_button 'Create Session'

    #   expect(page).to have_content I18n.t('api.v1.users.sessions.create.successful_enter')
    # end

    # it 'checks reset password link' do
    #   visit signin_path(locale: 'en')

    #   find_link(I18n.t('views.sessions.new.link')).click

    #   expect(page).to have_content I18n.t('views.password_resets.new.title')
    # end
  end

  describe '#edit' do
    before do
      allow(User).to receive(:find_by_token_for).with(:retest_token, token).and_return(user)

      allow(user).to receive(:authenticated?).and_return(true)
    end
    # visit edit_password_reset_url(params)
  end
end

# h1.header = t('views.password_resets.new.title')

# = form_for(:password_reset, url: password_resets_path) do |f|
#   div
#     = f.label :email, t('views.forms.email')
#     = f.email_field :email
#   div
#     = f.submit t('views.password_resets.new.submit')
