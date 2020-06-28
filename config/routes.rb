Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'home' => 'home#index'
  get 'genres' => 'genres#index'
  get 'resources' => 'resources#index'
  get 'songs' => 'songs#index'
  get 'elvis' => 'elvis#index'
  get 'reports' => 'reports#index'
  get 'inquiries' => 'inquiries#index'

end
