RSpec.shared_context 'when activated user is present' do
  let(:user) { create(:activated_user) }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true) }
end
