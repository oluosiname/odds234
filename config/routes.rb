require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    username == Rails.application.credentials[Rails.env.to_sym][:sidekiqweb][:username] &&
    password == Rails.application.credentials[Rails.env.to_sym][:sidekiqweb][:password]
  end

  mount Sidekiq::Web => "/sidekiq"
  namespace :v1 do
    post "/webhooks/events", to: "webhooks#events"
    resources :events, only: %i(index show), format: "json"
  end
end
