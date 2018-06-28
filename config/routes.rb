Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  post   '/', to: 'static_pages#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/edit', to: 'users#edit'
  get    '/edit_basic_info' , to: 'users#edit_basic_info'
  patch  '/update_basic_info' , to: 'users#update_basic_info'
  post   '/users/:user_id/works/:id/create_form' , to: 'works#create_form'
  
  resources :users do
    resources :works
  end
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  
end