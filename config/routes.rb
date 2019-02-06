Rails.application.routes.draw do
  root to: 'static_pages#home'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/download_resume', to: 'static_pages#download_resume'

  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  resources :users do
    member do
      get :following
    end
  end

  resources :outlets, only: [:index, :show] do
    resources :articles, only: [:show]
  end

  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
