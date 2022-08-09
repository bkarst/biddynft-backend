Rails.application.routes.draw do
  namespace :api do
    resources :poll_campaigns
  end
  namespace :api do
    resources :poll_responses
  end
  namespace :api do
    resources :polls
  end
  namespace :api do
    resources :poll_options
  end
  resources :nft_listings
  resources :nfts
  resources :bids
  scope '/api' do
    get '/nft_listings', to: 'api/nft_listing#index'
    get '/current_poll', to: 'api/polls#current'
    get '/take_snapshot/:id', to: 'api/poll_campaigns#snapshot'
    post '/record_snapshot/:id', to: 'api/poll_campaigns#record_snapshot'
    get '/nft_listing/:id', to: 'api/nft_listing#show'
    post '/bid', to: 'api/bid#create'
    post '/inactivate_poll/:id', to: 'api/polls#inactivate'
    post '/inactivate_poll_option/:id', to: 'api/poll_options#inactivate'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end