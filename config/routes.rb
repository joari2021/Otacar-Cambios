Rails.application.routes.draw do

  
  resources :mobile_payments
  resources :digital_payments
  resources :wallet_with_users
  resources :bank_brasils
  resources :wallets
  resources :banks
  resources :transactions
  resources :rates
  resources :config_loterica_deposits

  get '/payment_methods' => "payment_methods#index"
  get '/transaction-for-confirm' => "transactions#confirm"
  get '/set_method' => "payment_methods#set_method"
  get 'register_succesfull' => "register#index"
  get "/status_transactions", to: "transactions#status"
  get "/pending_transactions", to: "transactions#pending"
  
  devise_for :users, :controllers => { registrations: 'registrations' }, :path_names => { :sign_up => "register_or_login", :sign_in => "login_or_register" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dhasboard' => "home#index", :as => :user_root
 
end


