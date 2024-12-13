require 'rails_helper'

RSpec.describe 'Sessions', type: :feature do
  include_context 'when activated user is present'

  describe 'new' do
    it 'checks an error message' do
      visit signin_path(locale: 'en')

      expect(page).to have_content I18n.t('api.v1.users.sessions.new.title')

      within('#new_session') do
        fill_in user_form_interpolate(:email), with: email
        fill_in user_form_interpolate(:password), with: password
        check user_form_interpolate(:remember_me)
      end

      click_button 'Create Session'

      expect(page).to have_content I18n.t('api.v1.users.sessions.errors.invalid_password_or_email')
    end

    it 'checks redirection and flash' do
      visit signin_path(locale: 'en')

      within('#new_session') do
        fill_in user_form_interpolate(:email), with: user.email
        fill_in user_form_interpolate(:password), with: user.password
        check user_form_interpolate(:remember_me)
      end

      click_button 'Create Session'

      expect(page).to have_content I18n.t('api.v1.users.sessions.create.successful_enter')
    end
  end

  def user_form_interpolate(field)
    I18n.t field, scope: %i[api v1 users sessions new form]
  end
end
