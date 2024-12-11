require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  let(:user_email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true) }

  describe 'new' do
    it 'checks an error message' do
      visit new_user_path(locale: 'en')

      expect(page).to have_content I18n.t('api.v1.users.users.new.title')

      within('#new_user') do
        fill_in user_form_interpolate(:email), with: user_email
        fill_in user_form_interpolate(:password), with: user_email
        fill_in user_form_interpolate(:password_confirmation), with: user_email
      end

      click_button 'Create User'

      expect(page).to have_content I18n.t('dry_validation.errors.user.password_exclusion')
    end

    it 'checks redirection and flash' do
      visit new_user_path(locale: 'en')

      within('#new_user') do
        fill_in user_form_interpolate(:email), with: user_email
        fill_in user_form_interpolate(:password), with: password
        fill_in user_form_interpolate(:password_confirmation), with: password
      end

      click_button 'Create User'

      expect(page).to have_content I18n.t('api.v1.users.users.create.check_email')
    end
  end

  def user_form_interpolate(field)
    I18n.t field, scope: %i[api v1 users users new form]
  end
end
