Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper
  get 'example', to: 'example#index'
end
