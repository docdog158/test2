Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "home/about"=>"homes#about"
  
  devise_for :users
  
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
    
  end
  
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  	get "followings" => "relationships#followings", as: "followings"
  	get "followers" => "relationships#followers", as: "followers"
  end
  
  #検索機能
  get "/search", to: "searches#search"

  #ゲストユーザー
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :notifications, only: [:index, :show, :update]
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
