Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'menus#index'
  post 'menus/import', to: 'menus#import'
  get 'menus/export', to: 'menus#export'
  resources :menus
end
