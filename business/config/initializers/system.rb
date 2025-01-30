Dry::Rails.container do
  # cherry-pick features
  config.features = %i[application_contract]

  config.component_dirs.add 'app/operations'
end
