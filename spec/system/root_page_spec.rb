require 'rails_helper'

RSpec.describe 'RootPage', type: :system do
  it 'checks root page' do
    visit root_path

    expect(page).to have_content('Welcome to Bookstore')
  end
end
