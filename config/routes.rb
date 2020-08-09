Rails.application.routes.draw do
  root to: 'home#index'

  get 'home' => 'home#index'

  get 'genres' => 'genres#index'

  get 'resources' => 'resources#index'

  # optionally add 'scope' parameter 'best', 'elvis', or 'all'
  get '/songs/list/(:scope)', to: 'songs#index'
  get '/songs',               to: 'songs#index'

  get "songs/code/:code", to: "songs#show"

  get 'elvis' => 'elvis#index'

  get 'reports' => 'reports#index'
  get 'reports/:rpt_type', to: 'reports#show'

  get 'inquiries' => 'inquiries#index'
end
