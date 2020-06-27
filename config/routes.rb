Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'home' => 'home#index'
  get 'genres' => 'genres#index'
  get 'resources' => 'resources#index'

end
