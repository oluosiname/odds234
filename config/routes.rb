Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    post "/webhooks/events", to: "webhooks#events"
    resources :events, only: %i(index show), format: "json"
  end
end
