Rails.application.routes.draw do

  get 'payment_methods' => "payment_methods#index"
  get 'set_method' => "payment_methods#set_method"
  get 'register_succesfull' => "register#index"
  resources :transactions
  get "/status_transactions", to: "transactions#status"
  resources :rates
  resources :banks
  
  devise_for :users, :controllers => { registrations: 'registrations' }, :path_names => { :sign_up => "register_or_login", :sign_in => "login_or_register" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dhasboard' => "home#index", :as => :user_root
 
end


