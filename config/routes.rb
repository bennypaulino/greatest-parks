Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "posts#index"
  resources :posts, only: [:new, :create, :show] do
    resources :comments, only: :create
  end
end
