Rails.application.routes.draw do

  devise_for :questions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tests#index'

  resources :tests do
  resources :questions
  end

end
