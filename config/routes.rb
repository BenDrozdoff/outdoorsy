Rails.application.routes.draw do
  root :to => redirect('/customers')
  resources :customers, only: [:index]
  resources :customer_imports, only: [:create]
end
