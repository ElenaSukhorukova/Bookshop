require 'rails_helper'

RSpec.describe 'Users::new', type: :feature do
  let(:user) { create(:user) }

  describe 'new' do
    it 'checks an error message' do
      visit new_user_path(locale: 'en')

      within('#new_user') do
        fill_in 'Email', with: 'user@user.com'
        fill_in 'Password', with: 'user@user.com'
        fill_in 'Pasword confirmation', with: 'user@user.com'
      end

      click_button 'Create User'

      expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.password.exclusion')
    end
  end
end
