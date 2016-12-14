Rails.application.routes.draw do

  resources :stock_takes
  root 'welcome#index'

  get 'welcome/index'

  # resources for admin

  resources :clinics
  resources :products
  resources :stocks

  # security

  devise_for :users


  # api restfull routes

  namespace :api, defaults: {format: 'json'}  do
 
    resources :products 
    resources :clinics  
    resources :stocks
    resources :stock_takes
 
  end
end
