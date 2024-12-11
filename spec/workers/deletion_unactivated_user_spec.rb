require 'rails_helper'

RSpec.describe DeletionUnactivatedUser, type: :job do
  it { is_expected.to be_processed_in :default }
end
