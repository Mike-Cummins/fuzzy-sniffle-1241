Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 
  resources :dishes, only: [:show, :update]

  resources :chefs, only: [:show, :update] 

  resources :chef_dishes, only: [:create]

end
