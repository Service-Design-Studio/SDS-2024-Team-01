Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'my_devise/registrations' , :sessions => 'my_devise/sessions'}, path: "", path_names: {sign_in: 'login', password: 'forgot', confirmation: 'confirm', unblock: 'unblock', sign_up: 'register', sign_out: 'logout'}

    # ,path: "", controllers: {sessions: "sessions", registrations:"registrations"}, path_names: {sign_in: 'login', password: 'forgot', confirmation: 'confirm', unblock: 'unblock', sign_up: 'register', sign_out: 'logout'}
  resources :requests
  resources :devise
  root "requests#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Auth Controller (For authenticataion matters)
  get "login" => "auth#login"
  get "register" => "auth#register"

end
