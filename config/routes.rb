Rails.application.routes.draw do

  resources :mobile_payments, only: [ :new, :create, :destroy]
  resources :digital_payments, only: [ :new, :create, :destroy]
  resources :wallet_with_users, only: [ :new, :create, :destroy]
  resources :bank_brasils, only: [ :new, :create, :destroy]
  resources :wallets, only: [ :new, :create, :destroy]
  resources :banks, only: [ :new, :create, :destroy]

  get 'payment_methods' => "payment_methods#index"
  get 'set_method' => "payment_methods#set_method"
  get 'register_succesfull' => "register#index"
  resources :transactions
  get "/status_transactions", to: "transactions#status"
  resources :rates
  
  
  devise_for :users, :controllers => { registrations: 'registrations' }, :path_names => { :sign_up => "register_or_login", :sign_in => "login_or_register" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dhasboard' => "home#index", :as => :user_root
 
end


