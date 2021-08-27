Rails.application.routes.draw do
  devise_for :users
  
  root to:'homes#top'
  get 'homes/about' => 'homes#about'
  resources :books, only: [ :create, :edit, :update, :index, :show, :destroy]
  
  
  resources :users,only:[:index,:show,:edit,:update]
  

  
end
