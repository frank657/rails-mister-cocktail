Rails.application.routes.draw do
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cocktails do
    resources :doses, only: [:new, :create]
    member do
      get 'ingredient'
      get 'dose'
    end
  end
  resources :doses, only: [:destroy]
  root to: 'cocktails#index'
end
