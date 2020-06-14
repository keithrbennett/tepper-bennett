Rails.application.routes.draw do
  root to: 'static_pages#index'

  get "/reports" => "static_pages#include_reports"

end
