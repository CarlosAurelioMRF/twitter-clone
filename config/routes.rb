Rails.application.routes.draw do
  resources :posts
  get 'post/new'

  get 'post/create'

  get 'post/index'

  devise_for :users

resources :relationship, :only => []

get 'relationship/following'
get 'relationship/followers'

get 'relationship/follow', to: "relationship#follow", :as => 'follow'
get 'relationship/unfollow', to: "relationship#unfollow", :as => 'unfollow'

  devise_scope :user do
    authenticated :user do
     root 'posts#index', as: :authenticated_root
    end

    unauthenticated do
     root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
