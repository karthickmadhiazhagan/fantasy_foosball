Rails.application.routes.draw do
  # resources :matches
  resources :matches do
	resources :games
  end
  resources :games
  resources :players
  resources :teams
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
