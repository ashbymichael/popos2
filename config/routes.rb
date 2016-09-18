Rails.application.routes.draw do
  root 'popos#index'
  resources 'popos'
end
