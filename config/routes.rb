Rails.application.routes.draw do
  
  # 顧客用
# URL /users/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


# 管理者用
# URL /admin/sign_in ...
devise_for :admin,  skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 namespace :admin do
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:index, :show, :update]
    resources :comments, only: [:destroy]
    root "users#index"
  end
  
 scope module:  :public, shallow: true do
    
    get "/users/my_page" => "users#show"
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    resources :users, only: [:edit, :update]
    resources :posts, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create]
      resource :favorites, only: [:create, :destroy]
    end  
    
    root "homes#top"
    
    
    
    get "search" => "searches#search"
    # ゲストログイン用3
    # post "users/guest_sign_in", to: "sessions#guest_sign_in"
    
 end  
 devise_scope :user do
   post 'users/guest_sign_in', to: 'public/sessions#new_guest'
 end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
