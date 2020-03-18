require "resque_web"

Rails.application.routes.draw do

  mount ResqueWeb::Engine => "/resque_web"

  #root to: 'home#index'
  root :to => redirect('/admin')

  #root to: "searches#scrape"
  #get '/' => redirect('/admin')


  resources :searches
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #get '/admin/searches/stop/:id/' => 'admin_searches#stop'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
