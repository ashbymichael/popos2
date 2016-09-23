Rails.application.routes.draw do
  root 'welcome#index'
  resources 'popos'
  get '/markers' => 'popos#map_markers'
  post '/popos/nearby' => 'popos#nearby'
end
