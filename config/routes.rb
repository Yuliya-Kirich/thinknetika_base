Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tests
  resources :questions

  root 'tests#index'

  resource :tests do
    resource :questions
  end

  #get "tests/:category/:title", to: "tests#search"
  # get "questions/:body", to: "questions#search"
  match "tests/:id", to: "tests#create", via: %i[post put]
  get  "tests/:id/start", to: "tests#start"
  get "tests/:id/questions" , to: "tests#search_all_questions"

  end
