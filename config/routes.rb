Rails.application.routes.draw do

  get 'dashboard/summary'

  # security
  devise_for :admins
  resources :stock_takes
  root 'welcome#index'

  get 'welcome/index'

  # resources for admin

  resources :clinics
  resources :products
  resources :stocks
  resources :users

 

  # api restfull routes

  namespace :api, defaults: {format: 'json'}  do
 
    resources :products 
    resources :clinics  
    resources :stocks
    resources :stock_takes
    resources :users
 
  end
end
