MusicApp::Application.routes.draw do

  get "/search" => "search#create"
  post "/search" => "search#create"
  
  root              :to => 'static_pages#home', :as => 'home'
  match '/help',    :to => 'static_pages#help'
  match '/about',   :to => 'static_pages#about'
  match '/contact', :to => 'static_pages#contact'

  devise_for :users, :skip => [:sessions, :registrations, :passwords]
  
  as :user do
    get '/password' => 'devise/passwords#new', :as => :reset_password
    post '/password' => 'devise/passwords#create',:as => :reset_password
    get 'password/edit' => 'devise/passwords#edit', :as => :password_edit
    put '/password' => 'devise/passwords#update'

    get '/login ' => 'devise/sessions#new', :as => :login
    get '/login' => 'devise/sessions#new', :as => :new_user_session    
    post '/login' => 'devise/sessions#create', :as => :login
    delete '/logout' => 'devise/sessions#destroy', :as => :logout
    
    get '/singup' => 'devise/registrations#new', :as => :signup
    post '/singup' => 'devise/registrations#create', :as => :signup
    get '/edit' => 'devise/registrations#edit', :as => :edit_user
    delete '/users' => 'devise/registrations#destroy', :as => :delete_user
    put ':id' => 'devise/registrations#update', :as => :update_user

  end
             
  resources :users, :only => :show, :path => '/' do
    resources :events, :only => [:new, :create, :edit, :update, :show, :index]
  end
  
  resources :events, :only => :index
  get "event/show_image" => "events#show_image"
 
end
