Rails.application.routes.draw do

  resources :tasks

  get 'events/index'

  root 'tasks#index'
end
