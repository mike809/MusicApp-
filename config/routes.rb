MusicApp::Application.routes.draw do
  
  resources :users, :only => [:show, :edit, :update, :destroy] do
    resources :events, :only => [:new, :create, :edit, :update, :show, :index]
  end
  
  resources :events, :only => :index
  
  get '/signup', :to => 'users#new', :as => 'signup'
  post '/signup', :to => 'users#create', :as => 'signup'    
  
  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy', :as => 'logout'
  
  root              :to => 'static_pages#home', :as => 'home'
  match '/help',    :to => 'static_pages#help'
  match '/about',   :to => 'static_pages#about'
  match '/contact', :to => 'static_pages#contact'
  
  get '/reset_password', :to => 'password_reseters#new', :as => 'reset_password'
  post '/reset_password/',
       :to => 'password_reseters#create',
       :as => 'reset_password'
       
  get '/new_password', :to =>  'password_reseters#edit'
  
   
end
