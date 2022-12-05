Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get '/points', to: 'locations#index'

  resources :charging_sessions, only: %i[index show create], path: 'sessions' do
    member do 
      post 'stop'
    end
  end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
