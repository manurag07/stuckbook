# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'pages#home'

  resources :users, only: [:show, :index]
end
