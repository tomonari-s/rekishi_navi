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
    root "posts#index"
  end
  
 scope module:  :public, shallow: true do
    resources :users, only: [:edit, :update]
    get "/users/my_page" => "users#show"
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    resources :posts, only: [:new, :create, :show, :edit, :update, :destroy]
    root "homes#top"
    # ゲストログイン用3
    devise_scope :user do
      post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    end
 end  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
