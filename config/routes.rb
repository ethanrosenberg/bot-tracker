require "resque_web"

Rails.application.routes.draw do

  mount ResqueWeb::Engine => "/resque_web"

  #root to: "searches#scrape"
  get '/' => redirect('/admin')

  resources :searches
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
