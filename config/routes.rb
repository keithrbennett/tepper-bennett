Rails.application.routes.draw do
  root to: 'home#index'

  get 'home' => 'home#index'
  get 'genres' => 'genres#index'
  get 'resources' => 'resources#index'
  get 'songs' => 'songs#index'
  get "songs/:code", to: "songs#show"
  get 'elvis' => 'elvis#index'
  get 'reports' => 'reports#index'
  get 'reports/:rpt_type', to: 'reports#show'
  get 'inquiries' => 'inquiries#index'
end
