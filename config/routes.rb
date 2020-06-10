Rails.application.routes.draw do
  root to: 'static_pages#index'

  get "/reports" => "reports#show"

end
