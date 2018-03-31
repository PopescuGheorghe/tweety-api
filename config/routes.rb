# frozen_string_literal: true
require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq', constraints: SidekiqWebConstraint.new

  namespace :api, defaults: { format: :json } do
    resources :topics, only: [:show, :index, :create]
    get '/results/:date', to: 'statistics#show'
  end
end
