Rails.application.routes.draw do
  root to: 'home#index'

  get 'home' => 'home#index'
  get 'genres' => 'genres#index'
  get 'resources' => 'resources#index'
  get 'songs' => 'songs#index'
  get 'elvis' => 'elvis#index'
  get 'reports' => 'reports#index'
  get 'inquiries' => 'inquiries#index'

end
