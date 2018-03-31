# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :topic, only: [:show, :index, :create]
  end
end
