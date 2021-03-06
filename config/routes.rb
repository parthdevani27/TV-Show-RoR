Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  Rails.application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "shows#index"
  get "/shows" ,to: "shows#index"
  get "/shows/search" ,to: "shows#search"
  get "/favourites/:id" ,to: "shows#add_favourite"
  get "/favourites" ,to: "shows#favourites"
  delete "/favourites/:id", to: "shows#remove_favourites"
end
