Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/signup', to: 'sign_up#create'
  post '/signin', to: 'sign_in#create'
end
