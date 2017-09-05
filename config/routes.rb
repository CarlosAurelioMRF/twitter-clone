Rails.application.routes.draw do
  resources :posts
  get 'post/new'

  get 'post/create'

  get 'post/index'

  get 'post/follow'

  resources :relationships, :only => [:create, :destroy]

  devise_for :users

  devise_scope :user do
    authenticated :user do
     root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
     root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
