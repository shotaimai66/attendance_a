Rails.application.routes.draw do
  root   'static_pages#home'
  # static_pageコントローラー
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  post   '/', to: 'static_pages#create'
  # sessionコントローラー
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # userコントローラー
  get    '/edit', to: 'users#edit'
  get    '/edit_basic_info' , to: 'users#edit_basic_info'
  patch  '/update_basic_info' , to: 'users#update_basic_info'
  # user>workコントローラー
  post   '/users/:user_id/works/:id/create_form' , to: 'works#create_form'
  patch  '/users/:user_id/works/:id/create_overwork' , to: 'works#create_overwork'
  get    '/users/working_users'
  get    '/users/work_log' , to: 'works#work_log'
  post   '/users/:user_id/works/:id/create_monthwork' , to: 'works#create_monthwork'
  patch  '/users/:user_id/works/:id/update_monthwork' , to: 'works#update_monthwork'
  patch  '/users/:user_id/works/:id/update_overwork' , to: 'works#update_overwork'
  patch  '/users/:user_id/works/:id/update_changework' , to: 'works#update_changework'
  
  


  resources :users do
    resources :works
      get 'csv_output'
  end
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

end