Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root to: 'api/v1/external/store#shop_window'
    scope module: 'users' do
      get  :signin, to: 'sessions#new'
      post :signin, to: 'sessions#create'
      post :signout, to: 'sessions#destroy'
      # get '/auth/:provider/callback', to: 'sessions#omniauth'

      # resources :account_activations, only: %i[edit]
      # resources :password_resets, only: %i[new create update]
      # resources :user_mfa_session, only: %i[new create]

      resources :users, except: %i[index destroy] do
        # resources :profiles, except: %i[index], as: :customers, shallow: true
      end
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
